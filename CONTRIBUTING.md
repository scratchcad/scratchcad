# Contributing to scratchcad

Thanks for helping out. Bug reports, fixes, docs and new scripting functions are all welcome.

- **Bugs and ideas:** open an [issue](https://github.com/scratchcad/scratchcad/issues). For a
  bug, include the script that shows it, what you expected and what happened.
- **Security vulnerabilities:** don't open a public issue; report them privately as described in
  [SECURITY.md](SECURITY.md).
- **Larger changes:** open an issue first so we can agree on the approach before you spend time
  on it.

## Developer Certificate of Origin

Every commit must be signed off under the [Developer Certificate of Origin](https://developercert.org)
(DCO). By signing off you certify that you wrote the change, or otherwise have the right to submit
it under the project's licenses. A GitHub app checks every commit in a pull request, and a pull
request can't be merged until they all pass.

Sign off by committing with `-s`, which adds a line with the name and email in your git config:

```sh
git commit -s -m "fix(server): ..."
# Signed-off-by: Your Name <you@example.com>
```

The name and email must match the commit's author. To sign off commits you've already made:

```sh
git commit --amend --no-edit -s          # the last commit
git rebase --signoff origin/main         # every commit on your branch
git push --force-with-lease
```

## Licensing of contributions

Contributions to [`crates/`](crates) are licensed under the LGPL 2.1 only, and everything else
under the Apache License 2.0, the same as the code they change. Don't copy code from `crates/`
into the rest of the repo: it stays LGPL.

## Development setup

The repo root is a Cargo workspace with the server (`server/`) and the OpenCASCADE crates
(`crates/`); the MCP server and editor (`mcp/`) are a Node project. The quickest way to run
everything is `docker compose watch` from the root (see the [README](README.md)).

To build outside Docker you need:

- Rust 1.99 (`rustup toolchain install 1.99`)
- OpenCASCADE 7.8, found through `DEP_OCCT_ROOT`, with its libraries on `LD_LIBRARY_PATH`.
  Debian trixie's `libocct-*-dev` packages or conda-forge's `occt=7.8.1` both work. Don't enable
  scratchcad-occt-sys's `builtin` feature unless you want to compile OpenCASCADE from source
  (20+ minutes).
- Node.js and npm, for `mcp/`

[server/README.md](server/README.md), [mcp/README.md](mcp/README.md) and
[crates/README.md](crates/README.md) describe each part in more detail.

## Checks

CI runs these on every pull request; run them before pushing:

```sh
cargo fmt --all --check
cargo clippy --workspace --all-targets --locked -- -D warnings
cargo test --workspace --locked
cargo build --release --locked -p scratchcad   # the mcp integration tests run this binary

cd mcp
npm ci
npm run format:check && npm run lint && npm run typecheck
npm run coverage
npm run build
```

CI also enforces test coverage (90% of lines for the server, 95% for the crates, 100% for `mcp/`)
and runs `clang-format` 14 on the C++ headers in `crates/scratchcad-occt-sys/include/`. The full
list is in [.github/workflows/ci.yml](.github/workflows/ci.yml).

## Pull requests

- Keep a pull request to one change, and add tests for it.
- Commit messages and pull request titles follow
  [Conventional Commits](https://www.conventionalcommits.org), with a scope where it fits:
  `feat(mcp): ...`, `fix(server): ...`, `feat(crates): ...`, `docs: ...`. The changelog is
  written from them.
- Keep the docs in step with the code. A change to the scripting API also updates
  [`rhai-api.md`](crates/scratchcad-occt-rhai/docs/rhai-api.md), the scripting guide
  (`mcp/src/guide.ts`) and the editor's completions (`mcp/web/src/editor/rhai.ts`).
- After changing dependencies, regenerate `THIRD_PARTY_NOTICES.txt` with `npm run licenses` in
  `mcp/` (needs [cargo-about](https://github.com/EmbarkStudios/cargo-about)).
- Don't change version numbers; releases bump them.

A few rules keep scratchcad safe to run, and changes that break them won't be merged:

- Scripts never touch files. Only the MCP server reads and writes files, inside its output
  directory.
- OpenCASCADE runs only in worker processes, never in the server itself.
- Errors use one format everywhere: `{"error": {"code", "message"}}`.

[AGENTS.md](AGENTS.md) has more detail on these conventions.
