# scratchcad-mcp

The local half of scratchcad: an [MCP](https://modelcontextprotocol.io) server
that lets AI assistants model parts with the [scratchcad service](../server),
and a browser editor for the scripts it writes. Both run in one Node process
on your machine, because they share your output directory; the scratchcad
service they call can run anywhere.

```
your machine                                anywhere: local Docker, another box, the cloud
┌───────────────────────────────────┐       ┌──────────────────────────────┐
│ scratchcad-mcp  (this package)    │ HTTP  │ scratchcad service (server/) │
│  /mcp      tools for the agent    │──────▶│  runs scripts with           │
│  /         the editor             │       │  OpenCASCADE: measures,      │
│  /api/...  files + proxy          │       │  renders and exports them    │
└───────────────────────────────────┘       │  stateless, no file access   │
        │ reads and writes                  └──────────────────────────────┘
        ▼
   SCRATCHCAD_MCP_OUTPUT_DIR  (.rhai scripts, and STEP, IGES, BREP, STL, OBJ, 3MF exports)
```

It is TypeScript on Node 22.18+ (24 recommended), built with the
[MCP TypeScript SDK](https://github.com/modelcontextprotocol/typescript-sdk)
v2, Express, and for the editor React, Vite, Tailwind, CodeMirror and three.js.

## Tools

| tool              | endpoint                    | what the model uses it for                                                                                                          |
| ----------------- | --------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `validate_script` | `POST /v1/scripts/validate` | Catch Rhai errors (with line and column), and measure the part: its type, validity, bounding box, volume, area, center and warnings |
| `render_3d`       | `POST /v1/raster/3d`        | See the part: a shaded PNG with its sharp edges, as MCP image content, framed to fit unless told otherwise                          |
| `render_2d`       | `POST /v1/raster/2d`        | See inside the part: the cross-section at z = 0                                                                                     |
| `save_script`     | `POST /v1/scripts/validate` | Deliver the part: check the script, save it as `.rhai`, and return a link to it in the editor                                       |
| `read_script`     | —                           | Read a saved script back, including the user's edits from the editor                                                                |
| `export`          | `POST /v1/export/{format}`  | Write STEP, IGES, BREP, STL, OBJ or 3MF (the path's extension picks), when the user asks for a file                                 |

The server's MCP `instructions` carry a scripting guide: the modelling
functions (solids, sketches, booleans, fillets, selectors), how scripts produce
their shape, the units and axes, how to measure and look at a part, and the
conventions below. Every parameter is documented in the tool schemas, and
invalid or unknown arguments are rejected before any request is sent. Renders
say which view they used (`center` and `half_size`), so the model can keep the
same framing or zoom in.

## Setup

The Docker dev stack in the repo root runs it next to a local scratchcad:
`docker compose up --build`, then the editor is at <http://localhost:8000> and
MCP at `http://localhost:8000/mcp` (the repo's `.mcp.json` points Claude Code
there).

To run it directly (for example against a scratchcad running elsewhere):

```sh
cd mcp
npm ci && npm run build
SCRATCHCAD_URL=https://scratchcad.example.com \
SCRATCHCAD_MCP_TRANSPORT=http SCRATCHCAD_MCP_OUTPUT_DIR=~/parts npm start
```

Or let the MCP client start it over stdio. It then also serves the editor on
`SCRATCHCAD_MCP_PORT`; if another scratchcad-mcp already has that port (another
session, say), it leaves the editor to that one, and links to it only if it
shows the same output directory.

**Claude Code** (from the repo root, after `npm run build` in `mcp/`):

```sh
claude mcp add scratchcad -e SCRATCHCAD_MCP_OUTPUT_DIR="$PWD/output" -- node "$PWD/mcp/dist/server/main.js"
```

**Claude Desktop** and other clients that take a JSON config:

```json
{
  "mcpServers": {
    "scratchcad": {
      "command": "node",
      "args": ["/absolute/path/to/scratchcad/mcp/dist/server/main.js"],
      "env": {
        "SCRATCHCAD_URL": "http://127.0.0.1:8080",
        "SCRATCHCAD_MCP_OUTPUT_DIR": "/absolute/path/for/parts"
      }
    }
  }
}
```

## Configuration

| env                            | default                 |                                                                                                                               |
| ------------------------------ | ----------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `SCRATCHCAD_URL`               | `http://127.0.0.1:8080` | where the scratchcad service is listening; may include a path prefix                                                          |
| `SCRATCHCAD_API_TOKEN`         | unset                   | bearer token, if scratchcad was started with one. Only this process sends it; the editor's requests get it added by the proxy |
| `SCRATCHCAD_MCP_TIMEOUT_S`     | `90`                    | HTTP timeout per request to scratchcad                                                                                        |
| `SCRATCHCAD_MCP_OUTPUT_DIR`    | the working directory   | where scripts and meshes are read and written                                                                                 |
| `SCRATCHCAD_MCP_TRANSPORT`     | `stdio`                 | `stdio`, or `http` for streamable HTTP at `/mcp`                                                                              |
| `SCRATCHCAD_MCP_HOST`          | `127.0.0.1`             | HTTP bind address (editor, and `/mcp` in HTTP mode)                                                                           |
| `SCRATCHCAD_MCP_PORT`          | `8000`                  | HTTP port                                                                                                                     |
| `SCRATCHCAD_MCP_ALLOWED_HOSTS` | `localhost,127.0.0.1`   | `Host` and `Origin` hostnames accepted over HTTP                                                                              |
| `SCRATCHCAD_MCP_EDITOR`        | `on`                    | `off` to serve no editor (and, over stdio, no HTTP at all)                                                                    |

Every HTTP route checks the `Host` and `Origin` headers against the allowed
hosts, including when bound to `0.0.0.0` as in the container, so other websites
(and DNS rebinding) can't reach the tools, the files or the proxy through your
browser. `GET /healthz` returns `ok` for health checks. `/mcp` is stateless: each
request gets a fresh server, as the tools keep no state between calls.

## Scripts, the editor and the file API

A saved script is plain Rhai. Its top-level number assignments are its
parameters:

```rhai
// # Body
let width = 20.0; // [5, 50] Width (mm)
let holes = 4; // [1, 12] Number of holes
```

Scripts saved before scratchcad moved to OpenCASCADE start with a
`// region: ...` line, which told the editor where to mesh an implicit
surface. B-rep shapes need no such region; the line is only a comment now.

These are parameters: top-level `let` lines assigning a number,
with a `[min, max]` range and a plain-language label (with its unit) in a
trailing comment, grouped under `// # Section` lines. The editor shows each as a
labelled slider and rewrites only the number, keeping integers as integers. The
guide tells the model how to choose and name them, and `save_script` returns
the sliders it found (`parameters`) with `notes` on any that lack a range or
label, so the model can fix them. A parameter without a range gets one guessed
from the value it was saved with, which stays fixed while you drag.

The editor ([`web/`](web)) shows the part across two thirds of the window and
its parameters as sliders in the other third; the view follows the part as
sliders change its size (Auto-fit), with +Z up as in the scripts. The file
list slides out on demand, and the script editor (with error markers) takes
the sliders' place when asked for, so changing dimensions never needs the
script. It exports every format (STL files open in the view, the others
download from the file list), sets how finely meshes follow curved surfaces as
a fraction of the part's size, opens `?open=<path>` links, and talks only to
this process:

| route                         |                                                                                                                                                 |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| `GET /api/files`              | The scripts and exports, newest first, each with its `kind`, `format` and `version` (hidden directories are skipped)                            |
| `GET /api/files/<path>`       | One file, with its format's content type and its version in the `x-version` header                                                              |
| `PUT /api/files/<path>`       | Write a file atomically. With `x-expected-version: <version>` the write is refused with 409 if the file changed since; with `new`, if it exists |
| `POST /api/scratchcad/v1/...` | Forwarded to scratchcad's validate, raster and export endpoints, with the token added; warnings come back as one `x-warnings` JSON array        |

The file routes and the tools share one set of path rules: only scripts
(`.rhai`) and exports (`.step`, `.stp`, `.iges`, `.igs`, `.brep`, `.brp`,
`.stl`, `.obj`, `.3mf`) inside the output directory; paths that leave it
(`..`, absolute paths elsewhere, symlinks) are refused, and tools only replace
an existing file when the model passes `overwrite: true`. Errors use the scratchcad service's
format, `{"error": {"code": ..., "message": ...}}`. When the agent rewrites a
script the user hasn't edited, the editor reloads it; if both changed it, the
editor asks which version to keep.

## Development

```sh
npm ci
npm run dev                      # server with --watch, editor through Vite with hot reload
npm run format:check && npm run lint && npm run typecheck
npm run coverage                 # CI requires 100% coverage
npm run build                    # dist/server (compiled server) and dist/web (editor)
```

In development Node runs the TypeScript in `src/` directly (type stripping), and
Vite runs as middleware inside the server, so the editor and its API share one
port as in production. The same checks run in the dev container:
`docker compose run --rm mcp npm test`.

| directory     |                                                                                                     |
| ------------- | --------------------------------------------------------------------------------------------------- |
| `src/`        | The server: config, scratchcad client, tools, workspace (path rules), HTTP app, start-up            |
| `src/shared/` | Code the server and editor share (parameters, export formats)                                       |
| `web/`        | The editor                                                                                          |
| `tests/`      | Server tests: unit tests with a fake scratchcad, the HTTP app over real HTTP, and integration tests |

The integration tests run against a real scratchcad binary, from
`$SCRATCHCAD_BIN` or `../target/{release,debug}/scratchcad`, and are
skipped when none has been built (CI builds one). The binary links
OpenCASCADE dynamically, so `LD_LIBRARY_PATH` must find it (see
[`../server/README.md`](../server/README.md)). They run the scripting guide's
examples and the new-script template at both ends of every slider, and also
run the entry point as a process over stdio and over HTTP, including a forged
`Host` header being rejected.
