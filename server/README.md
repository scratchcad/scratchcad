# scratchcad

A lean HTTP service that models solid parts with
[OpenCASCADE](https://dev.opencascade.org) 7.8, through
[scratchcad-occt-rhai](https://github.com/scratchcad/scratchcad-occt-rs), and
[axum](https://github.com/tokio-rs/axum). You send it [Rhai](https://rhai.rs)
scripts that build B-rep solids, and it can:

- **validate scripts** and describe their shape: `POST /v1/scripts/validate`
- **rasterize** a shaded 3D view or the section at z = 0 to PNG: `POST /v1/raster/3d`, `POST /v1/raster/2d`
- **export** STEP, IGES, BREP, STL, OBJ or 3MF: `POST /v1/export/{format}`

To drive it from an AI assistant, see the MCP server in [`../mcp`](../mcp).
Run the commands below from this `server/` directory. For a containerised
dev setup with live reload, use `docker compose watch` from the repo root
(see [`Dockerfile.dev`](Dockerfile.dev)).

```sh
cargo run --release                       # listens on 0.0.0.0:8080
docker build -t scratchcad . && docker run -p 8080:8080 -e SCRATCHCAD_API_TOKEN=... scratchcad
```

Building needs Rust 1.99, CMake, a C++ compiler and OpenCASCADE 7.8, which
scratchcad-occt-rhai links (it never compiles it here). Two sources work:

- **conda-forge** (what CI uses):

  ```sh
  micromamba create -y -p /opt/occt -c conda-forge "occt=7.8.1=novtk*"
  export DEP_OCCT_ROOT=/opt/occt LD_LIBRARY_PATH=/opt/occt/lib
  ```

- **Debian 13 (trixie)**, as in the Docker images: `apt install cmake
  libocct-foundation-dev libocct-modeling-data-dev
  libocct-modeling-algorithms-dev libocct-ocaf-dev libocct-data-exchange-dev`.

## Scripts

Scripts use scratchcad-occt-rhai's functions: constructors such as
`box(dx, dy, dz)`, `cylinder(r, h)` and `sketch("XY")`, booleans as `+`, `-`
and `&`, methods such as `fillet`, `chamfer`, `shell`, `extrude` and
`revolve`, and CadQuery-style selectors (`">Z"`, `"|Z and >X"`) to pick
faces and edges. See its
[Rhai API reference](https://github.com/scratchcad/scratchcad-occt-rs/blob/main/docs/rhai-api.md).
Z is up and units are millimetres. A script produces its shape in one of two
ways:

- its last expression is the shape, e.g. `box(40, 30, 5).fillet(2, "|Z")`, or
- it calls `draw(shape)` exactly once.

A selection, sketch or array of shapes also works, and becomes a compound. A
script that builds nothing (say, a boolean that removes everything) is an
`unprocessable` error.

The API is **stateless**. Every request carries its script in a `"script"`
field, and nothing is stored between requests. Any instance can serve any
request, so replicas behind a load balancer need no coordination. Scripts
never touch files: they have no file functions and `import` loads nothing.

## API

Errors always have the shape `{"error": {"code": "...", "message": "..."}}`:

| status | code | meaning |
|---|---|---|
| 400 | `bad_request`, `invalid_json` | malformed or contradictory input (unknown fields are rejected) |
| 401 | `unauthorized` | missing or wrong bearer token |
| 404 | `not_found` | unknown route or export format |
| 413 | `payload_too_large` | body over `SCRATCHCAD_MAX_BODY_BYTES` |
| 422 | `script_error` | Rhai parse or runtime error, including failed modelling operations such as a fillet that is too large (message includes line and column) |
| 422 | `limit_exceeded` | a configured limit was hit (size, operations, triangles and so on) |
| 422 | `unprocessable` | the shape is empty, or can't be measured |
| 422 | `empty_mesh` | a mesh export of a shape with no faces (a wire, say) |
| 422 | `mesh_failed` | OpenCASCADE could not mesh the shape |
| 422 | `export_failed` | OpenCASCADE could not write the shape in the requested format |
| 503 | `overloaded` | no job slot became free within the queue timeout (`Retry-After: 1`) |
| 504 | `timeout` | the job ran past `SCRATCHCAD_JOB_TIMEOUT_MS` and was cancelled |

Every response carries an `x-request-id` header. If the request sent one, it
is propagated. PNG and export responses also carry `x-compute-ms` (the time
after the script ran), and one `x-warning` header per observation that didn't
stop the request.

### `POST /v1/scripts/validate`

Runs a script and describes the shape it builds. There is no field to sample
any more: measurements come from this summary, from `print()` in the script,
and from `contains(point)` and `classify(point)`.

```sh
curl -s localhost:8080/v1/scripts/validate -H 'content-type: application/json' \
  -d '{"script": "print(\"hi\"); box(10, 20, 30)"}'
```
```json
{"shape":{"type":"solid","solids":1,"faces":6,"edges":12,"vertices":8,"valid":true,
  "bounding_box":{"min":[0.0,0.0,0.0],"max":[10.0,20.0,30.0],"size":[10.0,20.0,30.0]},
  "volume":6000.0,"area":2200.0,"center":[5.0,10.0,15.0]},
 "output":["hi"],"warnings":[],"script_ms":1.2,"measure_ms":0.4}
```

`valid` is OpenCASCADE's checker's verdict. `warnings` names what will cause
trouble later: an invalid shape, or one with no solids (a face or wire where a
solid was probably meant). An invalid script returns the same `422` error the
other endpoints would.

### `POST /v1/raster/3d` → `image/png` (RGBA, transparent background)

A small software rasterizer over the shape's mesh: a z-buffer, Lambert
shading, the sharp B-rep edges drawn as dark lines (where two faces meet at
more than 30 degrees, so a fillet's tangent joins are left out), and 2x
supersampling. A shape without faces has its edges drawn instead, with a
warning.

| field | default | |
|---|---|---|
| `width`, `height` | required | pixels, `1..=SCRATCHCAD_MAX_IMAGE_SIZE_3D` |
| `mode` | `"shaded"` | `shaded`, `normals` (view-space normals as RGB) or `heightmap` (nearer is brighter) |
| `edges` | `true` | draw the sharp edges (`shaded` and `normals`) |
| `center` | the bounding box's center | model-space point at the view center |
| `half_size` | fits the part | the view spans `center ± half_size` along the image's longer axis |
| `rotation` | `{}` | `{"yaw": deg, "pitch": deg, "roll": deg}` |
| `perspective` | `0` | `0` is orthographic, up to `1` |

The camera looks along -z of its own frame with +y up. The rotation turns that
frame into model space, pitch first (about X), then roll (about Z), then yaw
(about Y). With no rotation it looks down the model's Z axis; `pitch: 90` is a
front view from -Y with +Z up, and `roll` then turns the view around the
model's Z axis. Without `half_size`, the view is just large enough to show
every corner of the bounding box from that angle. The response's
`x-view-center` and `x-view-half-size` headers give the view used, and
`x-mesh-tolerance` the tolerance it was meshed at (about half a pixel).

```sh
curl -s localhost:8080/v1/raster/3d -H 'content-type: application/json' -o part.png \
  -d '{"script": "box_centered(40, 30, 10).fillet(3, \"|Z\")", "width": 512, "height": 512,
       "rotation": {"pitch": 65, "roll": 30}, "perspective": 0.3}'
```

### `POST /v1/raster/2d` → `image/png`

Renders the section at z = 0, seen from above with +X right and +Y up, from
where the mesh's triangles cross the plane. A vertex on the plane counts as
below it, so a part resting on the XY plane shows the outline of its base.

| field | default | |
|---|---|---|
| `width`, `height` | required | pixels, `1..=SCRATCHCAD_MAX_IMAGE_SIZE_2D` |
| `mode` | `"mono"` | `mono` fills the section white on black (even-odd rule); `outline` draws its edges |
| `center` | the bounding box's center | model-space `[x, y]` at the image center |
| `half_size` | fits the part's x and y extent | the view spans `center ± half_size` along the image's longer axis |

A warning says when the plane misses the part, or crosses none of its faces.

### `POST /v1/export/{format}`

| format | content type | |
|---|---|---|
| `step` (or `stp`) | `model/step` | exact geometry (AP214), for CAD programs |
| `iges` (or `igs`) | `model/iges` | exact geometry, for older CAD programs |
| `brep` (or `brp`) | `application/octet-stream` | OpenCASCADE's native format |
| `stl` | `model/stl` | binary triangle mesh |
| `obj` | `model/obj` | triangle mesh |
| `3mf` | `model/3mf` | triangle mesh in millimetres, for 3D printing |

The body is `{"script": ..., "tolerance": ...}`. `tolerance` applies to the
mesh formats only (giving it for an exact format is a `400`): the largest
distance between the mesh and the true surface, by default 1e-3 of the
bounding box's diagonal and never finer than 1e-5 of it (a finer request is
raised to that, with a warning). Meshes also follow curves to within 15
degrees, and may have at most `SCRATCHCAD_MAX_MESH_TRIANGLES` triangles.

Mesh formats are written from the welded mesh, whose faces share the vertices
on their common edges, so a solid's mesh is watertight. Mesh responses carry
`x-triangle-count` and `x-mesh-tolerance`. Every response has
`Content-Disposition: attachment; filename="shape.<ext>"`.

### Health

- `GET /healthz`: liveness probe, always `200 ok`.
- `GET /readyz`: readiness probe. Returns `200` with job stats, or `503` once shutdown has begun.

Neither probe requires authentication.

## Production behaviour

- **Sandboxed scripts.** Rhai runs with an operation budget, limits on call depth, expression depth, string, array and map size. It has no file functions, no modules (`import` loads nothing) and no `eval`, and `print`/`debug` are captured into the response rather than written to stdout. Error tags are read-only, so a script can't pass its own errors off as the kernel's.
- **One thread per job.** OpenCASCADE shapes can't be shared between threads, so a job runs the script, meshes, renders and exports on one blocking thread and returns bytes. At most `SCRATCHCAD_MAX_CONCURRENT_JOBS` jobs run at once; other requests queue for up to `SCRATCHCAD_QUEUE_TIMEOUT_MS` and then get a `503`.
- **Real cancellation.** Every job runs under a `CancelToken` that trips on timeout **and** when the client disconnects. Booleans, shells, meshing (between faces) and STEP/IGES/BREP conversion stop part way, the script stops between operations, and the renderer checks it as it goes. Fillets, chamfers and lofts can't be interrupted once started, but don't start after a cancel. A job keeps its slot until it has actually stopped, so timed-out work never oversubscribes the machine.
- **Bounded inputs and outputs.** Limits cover body size, script size, image dimensions and triangle count. Every float input is checked to be finite.
- **Fault isolation.** A panic in a job or handler becomes a `500` with a generic message, and the details go to the logs under the request ID (the `x-request-id` response header).
- **Timeouts say what ran out.** A `504` names the stage that was running (the script, measuring, meshing, rendering or exporting) and the budget it exceeded.
- **Graceful shutdown.** On `SIGTERM` or `SIGINT`, readiness flips to `503`, queued jobs are rejected, in-flight requests finish, and blocking work gets 5 s to wind down.
- **Observability.** Structured logs (`SCRATCHCAD_LOG_FORMAT=json`, filtered with `RUST_LOG`) carry a per-request span with the request ID, and the log level is set by response status. OpenCASCADE's own warnings and failures are logged under the `occt` target instead of printed to stdout.
- **Authentication.** An optional bearer token (`SCRATCHCAD_API_TOKEN`, at least 16 chars) is compared in constant time, and the `Authorization` header is redacted from logs.
- The container image is `debian:trixie-slim` with Debian's OpenCASCADE libraries, and runs as a non-root user.

Put the service behind a reverse proxy or load balancer for TLS, connection
limits and slow-header protection. It doesn't terminate TLS itself.

## Configuration

Every option is a flag or an environment variable (`scratchcad --help`):

| env | default | |
|---|---|---|
| `SCRATCHCAD_LISTEN` | `0.0.0.0:8080` | bind address |
| `SCRATCHCAD_API_TOKEN` | unset | require `Authorization: Bearer <token>` on `/v1/*` |
| `SCRATCHCAD_LOG_FORMAT` | `text` | `text` or `json` |
| `SCRATCHCAD_MAX_CONCURRENT_JOBS` | `4` | parallel jobs |
| `SCRATCHCAD_QUEUE_TIMEOUT_MS` | `5000` | max wait for a job slot |
| `SCRATCHCAD_JOB_TIMEOUT_MS` | `30000` | per-job budget |
| `SCRATCHCAD_MAX_BODY_BYTES` | `4194304` | request body cap |
| `SCRATCHCAD_MAX_SCRIPT_BYTES` | `65536` | script size cap |
| `SCRATCHCAD_MAX_SCRIPT_OPERATIONS` | `1000000` | Rhai operation budget |
| `SCRATCHCAD_MAX_IMAGE_SIZE_2D` | `4096` | max 2D width and height |
| `SCRATCHCAD_MAX_IMAGE_SIZE_3D` | `2048` | max 3D width and height |
| `SCRATCHCAD_MAX_MESH_TRIANGLES` | `4000000` | max triangles in a mesh, for an export or a render |

## Development

With OpenCASCADE installed as above:

```sh
cargo fmt --check && cargo clippy --all-targets && cargo test
cargo llvm-cov --summary-only        # coverage (CI requires >= 90% of lines)
```

The tests cover three layers:
- unit tests next to the code (sandbox, job runner, measuring, meshing, the
  rasterizer, exports, errors)
- HTTP tests through the full router (`tests/api.rs`)
- end-to-end tests of the real binary, covering startup, TCP serving and
  SIGTERM/SIGINT shutdown (`tests/binary.rs`)

## Licence

scratchcad is Apache-2.0. It links scratchcad-occt-rhai and OpenCASCADE,
which are LGPL-2.1 (OpenCASCADE with an exception); see
[`../THIRD_PARTY_LICENSES.txt`](../THIRD_PARTY_LICENSES.txt) and
[`../NOTICE`](../NOTICE).
