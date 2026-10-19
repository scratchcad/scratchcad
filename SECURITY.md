# Security policy

## Supported versions

scratchcad is under active development. Security fixes go into `main` and the next release;
older releases are not patched, so upgrade to the
[latest release](https://github.com/scratchcad/scratchcad/releases/latest).

## Reporting a vulnerability

Please don't report security vulnerabilities in public issues, pull requests or discussions.

Report them privately through GitHub instead: open the repository's
[Security tab](https://github.com/scratchcad/scratchcad/security) and choose
**Report a vulnerability**
([direct link](https://github.com/scratchcad/scratchcad/security/advisories/new)). Only the
maintainers can see the report.

Include as much as you can of:

- the affected component (`server/`, `mcp/`, the editor or `crates/`) and version or commit
- what an attacker could do, and under what setup (for example, a deployed server with or without
  `SCRATCHCAD_API_TOKEN`)
- steps or a script that reproduce it

We'll acknowledge the report, keep you updated while we work on a fix, and credit you in the
advisory when it's published, unless you'd rather stay anonymous.

## Scope

Of particular interest are a script that can read or write files, reach the network, or escape a
worker's memory and CPU limits; a way past the API token; and the MCP server reading or writing
files outside its output directory.
