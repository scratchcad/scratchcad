# AGENTS.md

Notes for coding agents; `CLAUDE.md` imports this file. Read [README.md](README.md),
[server/README.md](server/README.md) (the HTTP API) and [mcp/README.md](mcp/README.md) (the MCP
tools and the editor) first. Scripts use [scratchcad-occt-rhai](crates/scratchcad-occt-rhai);
its [docs/rhai-api.md](crates/scratchcad-occt-rhai/docs/rhai-api.md) lists what they can call, and
its source is the final word. [crates/README.md](crates/README.md) and
[crates/scratchcad-occt-sys/README.md](crates/scratchcad-occt-sys/README.md) explain the crates
and how the bindings work.

## Layout

The repo root is a Cargo workspace: `server/` (the `scratchcad` binary) and the two crates in
`crates/`, which the server uses through path dependencies. Run cargo from the root; builds go to
`target/`. The server's Docker images build from the root too (see `.dockerignore`).

## Licensing

Everything outside `crates/` is Apache-2.0. `crates/` is LGPL-2.1-only, and each crate has its own
`LICENSE` and `NOTICE` (real files, not symlinks: a symlink breaks when the crate is published from
Windows).

* Don't move or copy code from `crates/` into `server/`, `mcp/` or anywhere else outside
  `crates/`: it would stay LGPL, and much of `scratchcad-occt-sys` comes from opencascade-rs, so
  it can't be relicensed. Use it through the crates' public API instead. New code that belongs in
  the crates goes in `crates/`.
* Keep the "Modified by ... Based on opencascade-rs" header on files derived from it; don't add it
  to new files. The crates' history before 2026-10-18 is in
  [scratchcad-occt-rs](https://github.com/scratchcad/scratchcad-occt-rs), which their `NOTICE`
  points to.
* Never use `license.workspace` or other inherited package fields for license metadata: the root
  is Apache-2.0 and the crates are not.

## Environment

The workspace needs Rust 1.99 (`rust-version` in `server/Cargo.toml`; `rustup toolchain install
1.99` if older) and OpenCASCADE 7.8, which scratchcad-occt-sys links. Never enable its `builtin`
feature: it compiles OpenCASCADE from source, which takes 20+ minutes. Cloud sessions install
conda-forge's prebuilt OCCT 7.8.1 into `/opt/occt`. If `ls $DEP_OCCT_ROOT/lib/libTKernel.so*`
finds nothing, install it (about 20 seconds):

```sh
curl -fsSL https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xj -C /usr/local bin/micromamba
MAMBA_ROOT_PREFIX=/opt/mamba micromamba create -y -p /opt/occt -c conda-forge "occt=7.8.1=novtk*"
export DEP_OCCT_ROOT=/opt/occt LD_LIBRARY_PATH=/opt/occt/lib
```

The binary, the tests and the mcp integration tests need `LD_LIBRARY_PATH` to find the libraries.
The Docker images use Debian trixie's `libocct-*` packages instead.

## Checks

CI ([.github/workflows/ci.yml](.github/workflows/ci.yml)) runs these; run them before pushing:

```sh
cargo fmt --all --check
cargo clippy --workspace --all-targets --locked -- -D warnings
cargo test --workspace --locked
cargo llvm-cov --locked -p scratchcad --fail-under-lines 90 --summary-only
cargo llvm-cov --locked -p scratchcad-occt-rhai -p scratchcad-occt-sys --fail-under-lines 95 --summary-only
clang-format --dry-run --Werror crates/scratchcad-occt-sys/include/*.hxx   # version 14
cargo build --release --locked -p scratchcad   # the mcp integration tests run this binary

cd mcp
npm ci
npm run format:check && npm run lint && npm run typecheck
npm run coverage                        # 100% of lines, branches and functions
npm run build
```

CI also builds the compose images (`docker compose config --quiet`, then the dev images). The crates
keep their own formatting (`crates/rustfmt.toml`, `crates/.clang-format`). Their tests run against
the real OCCT; shared helpers are in each crate's `tests/common/mod.rs`.

## Conventions

* Commit messages are Conventional Commits (`feat(mcp): ...`, `fix(server): ...`,
  `feat(crates): ...`); release-please writes the changelog from them.
* Errors use one format everywhere: `{"error": {"code", "message"}}`, with messages written for a
  model to act on.
* Keep the docs in step with the code: the READMEs, the scripting guide (`mcp/src/guide.ts`), the
  editor's completions (`mcp/web/src/editor/rhai.ts`) and
  `crates/scratchcad-occt-rhai/docs/rhai-api.md` when the scripting API changes.
* A new sys module needs `src/x.rs` (a cxx bridge), `include/x.hxx` and `pub mod x;` in
  `crates/scratchcad-occt-sys/src/lib.rs`. Bindings that can throw return `Result`; dereference
  handles only through `check_handle` or `handle_try_deref`.
* After changing dependencies, regenerate `THIRD_PARTY_LICENSES.txt` with `npm run licenses` in
  `mcp/` (needs cargo-about). OpenCASCADE isn't a crate, so its notice is written by that script.
* The crates are also published on crates.io for use outside scratchcad, with scratchcad's
  version; the server uses them by path, so it never waits on a release. Don't change their
  versions by hand: release-please bumps them with scratchcad's (the TOML `extra-files` in
  `release-please-config.json`, which also update their entries in `Cargo.lock`), and merging its
  release PR publishes them (`publish-crates` in `.github/workflows/release-please.yml`,
  `scratchcad-occt-sys` first). If a release PR fails `--locked`, the `Cargo.lock` entry there
  has stopped matching.

## Rules that matter

* **Scripts never touch files.** The server is stateless; scratchcad-occt-rhai's `register` gives
  scripts no file functions and `import` loads nothing. Keep it that way: only the MCP server reads
  and writes files, inside its output directory.
* **OpenCASCADE runs only in workers.** Each job runs in a `scratchcad worker` process
  (`worker.rs`), which `jobs.rs` kills on timeout or disconnect and which limits its own memory and
  CPU time. The server never touches a `Shape`: the worker runs the script, measures, meshes,
  renders and exports, and sends back bytes and plain data. A job's request and result types must
  stay serializable. Shapes (and the Rhai engine, without Rhai's `sync` feature, which must stay
  off) are not `Send`, so keep each job on one thread.
* **A worker's stdout is the protocol.** `worker::main` points stdout at stderr before anything
  else runs, and routes OpenCASCADE's messages to stderr through `set_message_handler`; the server
  logs the worker's stderr. Never print to the protocol channel.
