# scratchcad

A lean HTTP service that models solid parts with
[OpenCASCADE](https://dev.opencascade.org) 7.8, through
[scratchcad-occt-rhai](../crates/scratchcad-occt-rhai) (in [`../crates`](../crates)), and
[axum](https://github.com/tokio-rs/axum). You send it [Rhai](https://rhai.rs)
scripts that build B-rep solids, and it can:

- **validate scripts** and describe their shape: `POST /v1/scripts/validate`
- **rasterize** a shaded 3D view or the section at z = 0 to PNG: `POST /v1/raster/3d`, `POST /v1/raster/2d`
- **export** STEP, IGES, BREP, STL, OBJ or 3MF: `POST /v1/export/{format}`

To drive it from an AI assistant, see the MCP server in [`../mcp`](../mcp).
Run the commands below from this `server/` directory; it is a member of the
Cargo workspace at the repo root, so builds go to `../target`. The Docker
images build from the repo root, which holds the crates too. For a
containerised dev setup with live reload, use `docker compose watch` from the
repo root (see [`Dockerfile.dev`](Dockerfile.dev)).

```sh
cargo run --release                       # listens on 0.0.0.0:8080
docker build -t scratchcad -f Dockerfile .. && docker run -p 8080:8080 -e SCRATCHCAD_API_TOKEN=... scratchcad
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
[Rhai API reference](../crates/scratchcad-occt-rhai/docs/rhai-api.md).
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
| 422 | `limit_exceeded` | a configured limit was hit (size, operations, faces, triangles, file size, the worker's memory or CPU time and so on) |
| 422 | `unprocessable` | the shape is empty, or can't be measured |
| 422 | `empty_mesh` | a mesh export of a shape with no faces (a wire, say) |
| 422 | `mesh_failed` | OpenCASCADE could not mesh the shape |
| 422 | `export_failed` | OpenCASCADE could not write the shape in the requested format |
| 422 | `worker_crashed` | OpenCASCADE crashed the job's worker process, which it can do when it runs out of memory |
| 503 | `overloaded` | no job slot became free within the queue timeout (`Retry-After: 1`) |
| 504 | `timeout` | the job ran past `SCRATCHCAD_JOB_TIMEOUT_MS` and its worker was killed |

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

`volume`, `area` and `center` are exact to about 1e-7 of their size, also on
lofts, sweeps and other B-spline surfaces, which are measured on a copy split
into Bézier patches. On parts with a lot of B-spline geometry that takes the
longest of anything here (seconds for a 29-blade blisk), so
`"mass_properties": false` leaves the three out for callers that only need the
shape's size and topology, such as the editor's preview.

If the B-spline geometry can't be split into patches, the three are integrated directly
instead, which can be off by about a percent, and a warning says so; if OpenCASCADE can't
measure them at all, they are left out with a warning rather than failing the request.

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
degrees, and may have at most `SCRATCHCAD_MAX_MESH_TRIANGLES` triangles. A file
over `SCRATCHCAD_MAX_EXPORT_BYTES` is a `limit_exceeded` error; binary STL takes
50 bytes per triangle.

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
- **One worker process per job.** The server never runs OpenCASCADE itself. Each job (the script, then measuring, meshing, rendering or exporting) runs in a fresh `scratchcad worker` process, which gets the request on stdin and sends back bytes and plain data. At most `SCRATCHCAD_MAX_CONCURRENT_JOBS` jobs run at once; other requests queue for up to `SCRATCHCAD_QUEUE_TIMEOUT_MS` and then get a `503`. Starting a worker costs a few tens of milliseconds.
- **Killed, not cancelled.** Some OpenCASCADE operations (fillets, chamfers, lofts, sweeps) can't be interrupted once started, so a job that runs past its budget, or whose client disconnects, has its worker killed. The job keeps its slot until the worker has exited, so abandoned work never oversubscribes the machine, and that happens at once.
- **Memory and CPU limits.** A worker can use at most `SCRATCHCAD_WORKER_MEMORY_MIB` of heap (`RLIMIT_DATA`) and `SCRATCHCAD_WORKER_CPU_SECONDS` of CPU time, and dumps no core. Running out is a `limit_exceeded` error naming the stage. OpenCASCADE sometimes crashes instead of failing cleanly when it runs out of memory, and that is a `worker_crashed` error. Give the container `SCRATCHCAD_MAX_CONCURRENT_JOBS` × `SCRATCHCAD_WORKER_MEMORY_MIB` of memory, plus a little for the server. Workers inherit the environment except the `SCRATCHCAD_*` settings, so they never see the API token. They run as the same user as the server: they contain faults, but they are not a security boundary.
- **Bounded inputs and outputs.** Limits cover body size, script size, image dimensions, face count (checked before any measuring, meshing or exporting), triangle count and export size. Every float input is checked to be finite.
- **Fault isolation.** A panic in a handler, or a worker that dies for no reason above, becomes a `500` with a generic message, and the details go to the logs under the request ID (the `x-request-id` response header).
- **Timeouts say what ran out.** A `504` names the stage that was running (the script, measuring, meshing, rendering or exporting) and the budget it exceeded.
- **Graceful shutdown.** On `SIGTERM` or `SIGINT`, readiness flips to `503`, queued jobs are rejected and in-flight requests finish. Workers die with the server.
- **Observability.** Structured logs (`SCRATCHCAD_LOG_FORMAT=json`, filtered with `RUST_LOG`) carry a per-request span with the request ID, and the log level is set by response status. Workers write OpenCASCADE's own warnings and failures to their stderr, and the server logs them under the `occt` target, in the request's span.
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
| `SCRATCHCAD_JOB_TIMEOUT_MS` | `60000` | per-job budget; the worker is killed when it runs out |
| `SCRATCHCAD_WORKER_MEMORY_MIB` | `2048` | heap each job's worker may use |
| `SCRATCHCAD_WORKER_CPU_SECONDS` | `120` | CPU time each job's worker may use |
| `SCRATCHCAD_MAX_BODY_BYTES` | `4194304` | request body cap |
| `SCRATCHCAD_MAX_SCRIPT_BYTES` | `65536` | script size cap |
| `SCRATCHCAD_MAX_SCRIPT_OPERATIONS` | `1000000` | Rhai operation budget |
| `SCRATCHCAD_MAX_IMAGE_SIZE_2D` | `4096` | max 2D width and height |
| `SCRATCHCAD_MAX_IMAGE_SIZE_3D` | `2048` | max 3D width and height |
| `SCRATCHCAD_MAX_MESH_TRIANGLES` | `4000000` | max triangles in a mesh, for an export or a render |
| `SCRATCHCAD_MAX_FACES` | `100000` | max faces in a shape, checked before it is measured, meshed or exported |
| `SCRATCHCAD_MAX_EXPORT_BYTES` | `134217728` | max size of an exported file |

## Development

With OpenCASCADE installed as above:

```sh
cargo fmt --check && cargo clippy --all-targets && cargo test
cargo llvm-cov --summary-only        # coverage (CI requires >= 90% of lines)
```

The tests cover three layers:
- unit tests next to the code (sandbox, measuring, meshing, the rasterizer,
  exports, errors, and the job runner, with `sh` scripts standing in for
  workers)
- HTTP tests through the full router, with real workers (`tests/api.rs`)
- end-to-end tests of the real binary, covering startup, TCP serving, jobs and
  SIGTERM/SIGINT shutdown (`tests/binary.rs`)

## Licence

scratchcad is Apache-2.0. It links the crates in [`../crates`](../crates) and
OpenCASCADE, which are LGPL-2.1 (OpenCASCADE with an exception); see
[`../THIRD_PARTY_NOTICES.txt`](../THIRD_PARTY_NOTICES.txt) and
[`../NOTICE`](../NOTICE).
