// Regenerates THIRD_PARTY_NOTICES.txt after dependency changes.
//
//     cargo install --locked cargo-about --features cli   # once
//     npm run licenses                                    # in mcp/
//
// Rust: cargo-about, configured by server/about.toml (allowed licenses and
// target platforms) and server/about.hbs (output layout).
// OpenCASCADE: the C++ library the Rust bindings link. It comes from Debian
// packages (the Docker images) or conda-forge (CI), so cargo-about can't see
// it; its notice is written out below.
// JavaScript: the MCP server's and editor's runtime dependencies, as
// `npm ls --omit=dev` lists them after `npm ci` in mcp/, with each package's
// own license file. Dev tools (vite, vitest, eslint, ...) are left out.

import { execFileSync } from "node:child_process";
import { readdirSync, readFileSync, writeFileSync } from "node:fs";
import { join, resolve } from "node:path";

const ROOT = resolve(import.meta.dirname, "..", "..");
const OUTPUT = join(ROOT, "THIRD_PARTY_NOTICES.txt");
const RULE = "#".repeat(80);

interface PackageJson {
  name: string;
  version: string;
  license?: string;
  homepage?: string;
  repository?: string | { url?: string };
}

// Line endings are normalized so the output is the same on every platform.
function lf(text: string): string {
  return text.replace(/\r\n?/g, "\n");
}

function run(command: string, args: string[], cwd: string): string {
  // npm is npm.cmd on Windows, which only runs through a shell.
  const output = execFileSync(command, args, {
    cwd,
    encoding: "utf-8",
    stdio: ["ignore", "pipe", "inherit"],
    shell: process.platform === "win32",
  });
  return lf(output);
}

function banner(title: string): string {
  return `${RULE}\n${title}\n${RULE}\n\n`;
}

// OpenCASCADE's licence: the LGPL 2.1 (its text is in the Rust section, which
// lists the bindings under it) with this exception, from its
// OCCT_LGPL_EXCEPTION.txt.
const OPENCASCADE = `scratchcad makes use of Open CASCADE Technology (https://dev.opencascade.org),
version 7.8, a CAD kernel: the scratchcad service models, meshes and exports
shapes with it, through the scratchcad-occt-rhai and scratchcad-occt-sys
crates. It is linked as shared libraries, from Debian's libocct-* packages in
the Docker images (whose copyright files are in /usr/share/doc/libocct-*) or
conda-forge's occt package otherwise.

Copyright 1990-2000 Matra Datavision, 1999-2023 Open CASCADE SAS, and
others (see the copyright files above).

Open CASCADE Technology is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public License version
2.1 (its text is in the Rust section above, under "GNU Lesser General Public
License v2.1 only"), with the following exception.

Open CASCADE exception (version 1.0) to GNU LGPL version 2.1.

The object code (i.e. not a source) form of a "work that uses the Library"
can incorporate material from a header file that is part of the Library.
As a special exception to the GNU Lesser General Public License version 2.1,
you may distribute such object code incorporating material from header files
provided with the Open CASCADE Technology libraries (including code of CDL
generic classes) under terms of your choice, provided that you give
prominent notice in supporting documentation to this code that it makes use
of or is based on facilities provided by the Open CASCADE Technology software.
`;

/** The runtime npm packages: name, version, license, URL and license text. */
function javascriptLicenses(): string {
  const mcp = join(ROOT, "mcp");
  run("npm", ["ci", "--no-audit", "--no-fund", "--loglevel=error"], mcp);
  const paths = run("npm", ["ls", "--omit=dev", "--all", "--parseable"], mcp)
    .split(/\r?\n/)
    .filter(Boolean);
  const packages = new Map<string, { name: string; version: string; entry: string }>();
  for (const directory of paths.slice(1)) {
    // the first is the mcp package itself
    const meta = JSON.parse(readFileSync(join(directory, "package.json"), "utf-8")) as PackageJson;
    const repository = typeof meta.repository === "object" ? meta.repository.url : meta.repository;
    const url = meta.homepage || repository || "UNKNOWN";
    const files = readdirSync(directory, { withFileTypes: true })
      .filter((f) => f.isFile() && /^(LICENSE|LICENCE|COPYING)/.test(f.name.toUpperCase()))
      .map((f) => f.name)
      .sort();
    const text =
      files.map((f) => lf(readFileSync(join(directory, f), "utf-8")).trim()).join("\n") ||
      "UNKNOWN";
    packages.set(`${meta.name}@${meta.version}`, {
      name: meta.name,
      version: meta.version,
      entry: `${meta.license ?? "UNKNOWN"}\n${url}\n${text}`,
    });
  }
  const byName = (key: { name: string }) => key.name.toLowerCase();
  return [...packages.values()]
    .sort((a, b) => (byName(a) < byName(b) ? -1 : byName(a) > byName(b) ? 1 : 0))
    .map(({ name, version, entry }) => `${name}\n${version}\n${entry}\n`)
    .join("");
}

const rust = run("cargo", ["about", "generate", "--locked", "about.hbs"], join(ROOT, "server"));
writeFileSync(
  OUTPUT,
  "Third-party software used by scratchcad, generated by mcp/scripts/third-party-licenses.ts.\n\n" +
    banner("RUST DEPENDENCIES (server/), generated by cargo-about") +
    rust +
    "\n" +
    banner("OPENCASCADE TECHNOLOGY (linked by server/)") +
    OPENCASCADE +
    "\n" +
    banner("JAVASCRIPT DEPENDENCIES (mcp/), from npm ls and each package's license file") +
    javascriptLicenses(),
  "utf-8",
);
console.log(`wrote ${OUTPUT}`);
