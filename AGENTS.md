# AGENTS.md

Notes for coding agents; `CLAUDE.md` imports this file. Read [README.md](README.md),
[server/README.md](server/README.md) (the HTTP API) and [mcp/README.md](mcp/README.md) (the MCP
tools and the editor) first. Scripts use
[scratchcad-occt-rhai](https://github.com/scratchcad/scratchcad-occt-rs); its
[docs/rhai-api.md](https://github.com/scratchcad/scratchcad-occt-rs/blob/main/docs/rhai-api.md)
lists what they can call, and its source is the final word.

## Environment

`server/` needs Rust 1.99 (`rust-version`; `rustup toolchain install 1.99` if older) and
OpenCASCADE 7.8, which scratchcad-occt-rhai links. Never enable its `builtin` feature: it compiles
OpenCASCADE from source, which takes 20+ minutes. Cloud sessions install conda-forge's prebuilt
OCCT 7.8.1 into `/opt/occt`. If `ls $DEP_OCCT_ROOT/lib/libTKernel.so*` finds nothing, install it
(about 20 seconds):

```sh
curl -fsSL https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xj -C /usr/local bin/micromamba
MAMBA_ROOT_PREFIX=/opt/mamba micromamba create -y -p /opt/occt -c conda-forge "occt=7.8.1=novtk*"
export DEP_OCCT_ROOT=/opt/occt LD_LIBRARY_PATH=/opt/occt/lib
```

The binary and the mcp integration tests need `LD_LIBRARY_PATH` to find the libraries. The Docker
images use Debian trixie's `libocct-*` packages instead.

## Checks

CI ([.github/workflows/ci.yml](.github/workflows/ci.yml)) runs these; run them before pushing:

```sh
cd server
cargo fmt --check
cargo clippy --all-targets --locked -- -D warnings
cargo test --locked
cargo llvm-cov --locked --fail-under-lines 90 --summary-only
cargo build --release --locked          # the mcp integration tests run this binary

cd ../mcp
npm ci
npm run format:check && npm run lint && npm run typecheck
npm run coverage                        # 100% of lines, branches and functions
npm run build
```

CI also builds the compose images (`docker compose config --quiet`, then the dev images).

## Conventions

* Commit messages are Conventional Commits (`feat(mcp): ...`, `fix(server): ...`); release-please
  writes the changelog from them.
* Errors use one format everywhere: `{"error": {"code", "message"}}`, with messages written for a
  model to act on.
* Keep the docs in step with the code: the READMEs, the scripting guide (`mcp/src/guide.ts`) and the
  editor's completions (`mcp/web/src/editor/rhai.ts`) when the scripting API changes.
* After changing dependencies, regenerate `THIRD_PARTY_LICENSES.txt` with `npm run licenses` in
  `mcp/` (needs cargo-about). OpenCASCADE isn't a crate, so its notice is written by that script.

## Rules that matter

* **Scripts never touch files.** The server is stateless; scratchcad-occt-rhai's `register` gives
  scripts no file functions and `import` loads nothing. Keep it that way: only the MCP server reads
  and writes files, inside its output directory.
* **A `Shape` stays on one thread.** Shapes (and the Rhai engine, without Rhai's `sync` feature,
  which must stay off) are not `Send`. Build the engine, run the script, mesh, render and export
  inside one job (`jobs.rs`), and return bytes or plain data. `shape.detach()` exists if a shape
  must cross threads.
* **OpenCASCADE output goes through `set_message_handler`.** OCCT prints to stdout, which carries
  the server's logs; `main.rs` routes its messages to `tracing` before any thread starts.
