// The MCP tools, exercised through a real MCP client session in memory.
import fs from "node:fs";
import path from "node:path";
import type { Client } from "@modelcontextprotocol/client";
import { describe, expect, it } from "vitest";
import { EXAMPLES, GUIDE } from "../src/guide.ts";
import {
  connect,
  FakeScratchcad,
  PNG,
  response,
  SCRIPT,
  SHAPE,
  scratchcadError,
  TOOLS,
  testSettings,
  VALIDATED,
} from "./helpers.ts";

type Content = { type: string; text?: string; data?: string; mimeType?: string };

async function setup(editorUrl: string | null = null) {
  const fake = new FakeScratchcad();
  const settings = testSettings();
  const client = await connect(settings, fake, editorUrl);
  return { fake, settings, out: settings.outputDir, client };
}

async function call(client: Client, name: string, args: Record<string, unknown>) {
  const result = await client.callTool({ name, arguments: args });
  return result as {
    content: Content[];
    structuredContent?: Record<string, unknown>;
    isError?: boolean;
  };
}

/** Calls a tool that is expected to fail and returns the error text the model sees. */
async function callError(client: Client, name: string, args: Record<string, unknown>) {
  const result = await call(client, name, args);
  expect(result.isError).toBe(true);
  expect(result.content).toHaveLength(1);
  return result.content[0]!.text!;
}

describe("discovery", () => {
  it("lists exactly the tools", async () => {
    const { client } = await setup();
    expect((await client.listTools()).tools.map((t) => t.name).sort()).toEqual([...TOOLS].sort());
  });

  it("carries the scripting guide as instructions", async () => {
    const { client } = await setup();
    expect(client.getInstructions()).toBe(GUIDE);
    for (const needle of [
      "OpenCASCADE",
      "Z is up",
      "millimetres",
      "draw(shape)",
      "box_centered(",
      "fillet(",
      "sketch(",
      '">Z"',
      "degrees",
      "try {",
      "validate_script",
      "save_script",
      "read_script",
      "editor_url",
      "Only call export when the user asks",
      "// [10, 60]",
      "Label (unit)",
      "// # Head",
      "integer division truncates",
    ]) {
      expect(GUIDE).toContain(needle);
    }
    // The examples are in the guide as they are run by the integration tests
    for (const example of Object.values(EXAMPLES)) {
      expect(GUIDE).toContain(example.split("\n")[0]);
    }
    expect(GUIDE).not.toMatch(/half_size=|region|implicit|negative inside/i);
  });

  it("documents every parameter", async () => {
    const { client } = await setup();
    for (const tool of (await client.listTools()).tools) {
      expect(tool.description, tool.name).toBeTruthy();
      const required = tool.name === "read_script" ? "path" : "script";
      expect(tool.inputSchema.required).toContain(required);
      expect(tool.inputSchema.additionalProperties).toBe(false);
      for (const [name, schema] of Object.entries(tool.inputSchema.properties ?? {})) {
        expect(
          (schema as { description?: string }).description,
          `${tool.name}.${name}`,
        ).toBeTruthy();
      }
    }
  });

  it("marks only export and save as writing", async () => {
    const { client } = await setup();
    const tools = Object.fromEntries((await client.listTools()).tools.map((t) => [t.name, t]));
    for (const name of TOOLS) {
      const annotations = tools[name]!.annotations!;
      if (name === "export" || name === "save_script") {
        expect(annotations).toMatchObject({ readOnlyHint: false, destructiveHint: true });
      } else {
        expect(annotations).toMatchObject({ readOnlyHint: true, idempotentHint: true });
      }
    }
  });

  it("carries the input constraints", async () => {
    const { client } = await setup();
    const props = Object.fromEntries(
      (await client.listTools()).tools.map((t) => [
        t.name,
        t.inputSchema.properties as Record<string, Record<string, unknown>>,
      ]),
    );
    expect(props.render_3d!.perspective!.maximum).toBe(1);
    expect(props.render_3d!.width!.minimum).toBe(1);
    expect(props.render_3d!.mode!.enum).toEqual(["shaded", "normals", "heightmap"]);
    expect(props.render_3d!.half_size!.exclusiveMinimum).toBe(0);
    expect(props.render_2d!.mode!.enum).toEqual(["mono", "outline"]);
    expect(props.export!.tolerance!.exclusiveMinimum).toBe(0);
    expect(Object.keys(props.export!)).toEqual(
      expect.arrayContaining(["path", "overwrite", "tolerance"]),
    );
    expect(Object.keys(props.save_script!).sort()).toEqual(["overwrite", "path", "script"]);
  });
});

describe("validate_script", () => {
  it("describes the shape", async () => {
    const { client, fake } = await setup();
    const result = await call(client, "validate_script", { script: SCRIPT });
    expect(result.structuredContent).toEqual(VALIDATED);
    expect(JSON.parse(result.content[0]!.text!)).toEqual(result.structuredContent);
    expect(fake.last.url.pathname).toBe("/v1/scripts/validate");
    expect(fake.last.body).toEqual({ script: SCRIPT });
  });

  it("passes script errors to the model verbatim", async () => {
    const { client, fake } = await setup();
    fake.handler = scratchcadError(
      422,
      "script_error",
      "script error: Script is incomplete (line 1, position 12)",
    );
    expect(await callError(client, "validate_script", { script: "let q = 1 +" })).toBe(
      "script_error: script error: Script is incomplete (line 1, position 12)",
    );
  });

  it("rejects a missing script before sending anything", async () => {
    const { client, fake } = await setup();
    expect(await callError(client, "validate_script", {})).toContain("script");
    expect(fake.requests).toEqual([]);
  });
});

describe("render_2d and render_3d", () => {
  it("render_2d returns the PNG and the view it fitted", async () => {
    const { client, fake } = await setup();
    const result = await call(client, "render_2d", { script: SCRIPT });
    expect(result.content).toEqual([
      { type: "image", data: PNG.toString("base64"), mimeType: "image/png" },
      {
        type: "text",
        text:
          "View: center=[0,0] half_size=16.2. Pass them back to keep this framing, or a " +
          "smaller half_size to zoom in.",
      },
    ]);
    expect(fake.last.url.pathname).toBe("/v1/raster/2d");
    // No center or half_size: scratchcad fits the part
    expect(fake.last.body).toEqual({ script: SCRIPT, width: 512, height: 512, mode: "mono" });
  });

  it("render_2d passes every option", async () => {
    const { client, fake } = await setup();
    const args = { width: 64, height: 32, mode: "outline", center: [1, -1], half_size: 3 };
    await call(client, "render_2d", { script: SCRIPT, ...args });
    expect(fake.last.body).toEqual({ script: SCRIPT, ...args });
  });

  it.each(["render_2d", "render_3d"])("%s puts warnings last", async (tool) => {
    const { client, fake } = await setup();
    fake.handler = () =>
      response(200, PNG, { "x-warning": ["the plane z = 0 misses the part", "second"] });
    const result = await call(client, tool, { script: SCRIPT });
    // Without view headers there is no view text
    expect(result.content.map((c) => c.type)).toEqual(["image", "text", "text"]);
    expect(result.content[1]!.text).toBe("Warning: the plane z = 0 misses the part");
  });

  it("render_3d defaults to a three-quarter view from the front right", async () => {
    const { client, fake } = await setup();
    const result = await call(client, "render_3d", { script: SCRIPT });
    expect(result.content).toHaveLength(2);
    expect(result.content[1]!.text).toContain("center=[0,0,0] half_size=21.5");
    expect(fake.last.url.pathname).toBe("/v1/raster/3d");
    expect(fake.last.body).toEqual({
      script: SCRIPT,
      width: 512,
      height: 512,
      mode: "shaded",
      edges: true,
      rotation: { yaw: 0, pitch: 65, roll: 30 },
      perspective: 0,
    });
  });

  it("render_3d passes every option", async () => {
    const { client, fake } = await setup();
    await call(client, "render_3d", {
      script: SCRIPT,
      width: 256,
      height: 128,
      yaw: 90,
      pitch: 45,
      roll: 10,
      center: [1, 2, 3],
      half_size: 20,
      mode: "normals",
      edges: false,
      perspective: 0.5,
    });
    expect(fake.last.body).toEqual({
      script: SCRIPT,
      width: 256,
      height: 128,
      mode: "normals",
      edges: false,
      center: [1, 2, 3],
      half_size: 20,
      rotation: { yaw: 90, pitch: 45, roll: 10 },
      perspective: 0.5,
    });
  });

  it.each([
    { width: 0 },
    { height: -5 },
    { width: 1.5 },
    { perspective: 1.5 },
    { perspective: -0.1 },
    { half_size: 0 },
    { mode: "wireframe" },
    { evaluator: "vm" },
    { ssao: true },
    { center: [1, 2] },
    { unknown: 1 },
  ])("render_3d rejects %o locally", async (args) => {
    const { client, fake } = await setup();
    await callError(client, "render_3d", { script: SCRIPT, ...args });
    expect(fake.requests).toEqual([]);
  });
});

describe("export", () => {
  it("writes a mesh", async () => {
    const { client, fake, out } = await setup();
    const result = await call(client, "export", { script: SCRIPT, path: "part.stl" });
    const target = path.join(out, "part.stl");
    expect(result.structuredContent).toEqual({
      path: target,
      format: "stl",
      bytes: 10,
      triangles: 1234,
      tolerance: 0.0374,
      compute_ms: 40.25,
      warnings: [],
    });
    expect(fs.readFileSync(target, "utf8")).toBe("mesh-bytes");
    expect(fake.last.url.pathname).toBe("/v1/export/stl");
    expect(fake.last.body).toEqual({ script: SCRIPT });
  });

  it.each([
    ["part.step", "step"],
    ["part.STP", "step"],
    ["part.igs", "iges"],
    ["part.brep", "brep"],
    ["part.obj", "obj"],
    ["part.3mf", "3mf"],
  ])("picks the format of %s from its extension", async (target, format) => {
    const { client, fake, out } = await setup();
    const result = await call(client, "export", { script: SCRIPT, path: target });
    expect(result.structuredContent!.format).toBe(format);
    expect(fake.last.url.pathname).toBe(`/v1/export/${format}`);
    expect(fs.existsSync(path.join(out, target))).toBe(true);
  });

  it("passes a tolerance for meshes, and refuses one for exact formats", async () => {
    const { client, fake } = await setup();
    await call(client, "export", { script: SCRIPT, path: "p.3mf", tolerance: 0.05 });
    expect(fake.last.body).toEqual({ script: SCRIPT, tolerance: 0.05 });
    const requests = fake.requests.length;
    const text = await callError(client, "export", {
      script: SCRIPT,
      path: "p.step",
      tolerance: 0.05,
    });
    expect(text).toBe(
      "tolerance only applies to mesh formats (stl, obj, 3mf); step stores exact geometry",
    );
    expect(fake.requests).toHaveLength(requests);
  });

  it("reports warnings", async () => {
    const { client, fake, out } = await setup();
    fake.handler = () =>
      response(200, Buffer.from("mesh-bytes"), {
        "x-triangle-count": "8",
        "x-warning": "the shape is a face with no solids, so the mesh is not watertight",
      });
    const result = await call(client, "export", { script: SCRIPT, path: "part.stl" });
    expect(result.structuredContent!.warnings).toEqual([
      "the shape is a face with no solids, so the mesh is not watertight",
    ]);
    expect(fs.existsSync(path.join(out, "part.stl"))).toBe(true);
  });

  it("creates subdirectories and accepts absolute paths inside the output directory", async () => {
    const { client, out } = await setup();
    await call(client, "export", { script: SCRIPT, path: "parts/v2/bracket.STL" });
    expect(fs.readFileSync(path.join(out, "parts/v2/bracket.STL"), "utf8")).toBe("mesh-bytes");
    await call(client, "export", { script: SCRIPT, path: path.join(out, "abs.step") });
    expect(fs.existsSync(path.join(out, "abs.step"))).toBe(true);
  });

  it("refuses to overwrite by default", async () => {
    const { client, fake, out } = await setup();
    const target = path.join(out, "part.stl");
    fs.writeFileSync(target, "original");
    const text = await callError(client, "export", { script: SCRIPT, path: "part.stl" });
    expect(text).toContain("already exists");
    expect(text).toContain("overwrite");
    expect(fs.readFileSync(target, "utf8")).toBe("original");
    expect(fake.requests).toEqual([]);
    await call(client, "export", { script: SCRIPT, path: "part.stl", overwrite: true });
    expect(fs.readFileSync(target, "utf8")).toBe("mesh-bytes");
  });

  it.each([
    ["../escape.stl", "inside the output directory"],
    ["/etc/evil.stl", "inside the output directory"],
    ["sub/../../escape.stl", "inside the output directory"],
    ["part.dxf", "end in .step, .stp, .iges, .igs, .brep, .brp, .stl, .obj or .3mf"],
    ["part.rhai", "end in .step"],
    ["part", "end in .step"],
    ["   ", "must not be empty"],
  ])("rejects the path %s", async (target, message) => {
    const { client, fake } = await setup();
    expect(await callError(client, "export", { script: SCRIPT, path: target })).toContain(message);
    expect(fake.requests).toEqual([]);
  });

  it("rejects escaping through a symlinked directory", async () => {
    const { client, out } = await setup();
    const outside = testSettings().outputDir;
    fs.symlinkSync(outside, path.join(out, "link"));
    expect(await callError(client, "export", { script: SCRIPT, path: "link/x.stl" })).toContain(
      "inside the output directory",
    );
    expect(fs.readdirSync(outside)).toEqual([]);
  });

  it("works with a symlinked output directory", async () => {
    const real = testSettings().outputDir;
    const alias = path.join(testSettings().outputDir, "alias");
    fs.symlinkSync(real, alias);
    const fake = new FakeScratchcad();
    const client = await connect(testSettings({ outputDir: alias }), fake);
    await call(client, "export", { script: SCRIPT, path: "part.stl" });
    expect(fs.readFileSync(path.join(real, "part.stl"), "utf8")).toBe("mesh-bytes");
  });

  it("rejects a directory target", async () => {
    const { client, fake, out } = await setup();
    fs.mkdirSync(path.join(out, "folder.stl"));
    const text = await callError(client, "export", {
      script: SCRIPT,
      path: "folder.stl",
      overwrite: true,
    });
    expect(text).toContain("is a directory");
    expect(fake.requests).toEqual([]);
  });

  it("writes nothing when scratchcad fails", async () => {
    const { client, fake, out } = await setup();
    fake.handler = scratchcadError(422, "empty_mesh", "the shape is a wire with no faces");
    const text = await callError(client, "export", { script: "circle(5)", path: "w.stl" });
    expect(text.startsWith("empty_mesh: the shape is a wire with no faces")).toBe(true);
    expect(fs.existsSync(path.join(out, "w.stl"))).toBe(false);
  });
});

describe("save_script and read_script", () => {
  it("validates and writes the script", async () => {
    const { client, fake, out } = await setup("http://localhost:8000/");
    const result = await call(client, "save_script", {
      script: SCRIPT,
      path: "parts/my part.rhai",
    });
    const text = `${SCRIPT}\n`;
    expect(fs.readFileSync(path.join(out, "parts/my part.rhai"), "utf8")).toBe(text);
    expect(result.structuredContent).toEqual({
      path: path.join(out, "parts/my part.rhai"),
      bytes: text.length,
      shape: SHAPE,
      warnings: [],
      editor_url: "http://localhost:8000/?open=parts%2Fmy%20part.rhai",
      parameters: [],
      notes: [expect.stringContaining("no parameters, so the user gets no sliders")],
    });
    expect(fake.last.url.pathname).toBe("/v1/scripts/validate");
    expect(fake.last.body).toEqual({ script: SCRIPT });
  });

  it("passes on the shape's warnings", async () => {
    const { client, fake } = await setup();
    fake.handler = () => response(200, { ...VALIDATED, warnings: ["the shape has no solids"] });
    const result = await call(client, "save_script", { script: "circle(5)", path: "c.rhai" });
    expect(result.structuredContent!.warnings).toEqual(["the shape has no solids"]);
  });

  it("lists the sliders the script makes, and what's unclear about them", async () => {
    const { client } = await setup();
    const script = [
      "// # Body",
      "let width = 20.0; // [5, 50] Width (mm)",
      "let depth = 8.0;",
      "box(width, depth, 2)",
    ].join("\n");
    const result = await call(client, "save_script", { script, path: "a.rhai" });
    expect(result.structuredContent!.parameters).toEqual([
      { name: "width", label: "Width (mm)", section: "Body", value: 20, min: 5, max: 50 },
      { name: "depth", label: "Depth", section: "Body", value: 8, min: 0, max: 16 },
    ]);
    expect(result.structuredContent!.notes).toEqual([
      "depth has no [min, max] range, so its slider guesses 0 to twice the value",
      'depth has no label: add one after the range, with units, e.g. "Width (mm)"',
    ]);
  });

  it("has no editor link when the editor is off", async () => {
    const { client } = await setup(null);
    const result = await call(client, "save_script", { script: SCRIPT, path: "a.rhai" });
    expect(result.structuredContent!.editor_url).toBeNull();
  });

  it("keeps the script as written, apart from trailing blank lines", async () => {
    const { client, out } = await setup();
    // Scripts saved before the region line went away still run: it's a comment.
    const script = `// region: center=[0, 0, 5] half_size=12\n${SCRIPT}\n\n\n`;
    await call(client, "save_script", { script, path: "a.rhai" });
    expect(fs.readFileSync(path.join(out, "a.rhai"), "utf8")).toBe(
      `// region: center=[0, 0, 5] half_size=12\n${SCRIPT}\n`,
    );
  });

  it("rejects the old region arguments", async () => {
    const { client, fake } = await setup();
    await callError(client, "save_script", { script: SCRIPT, path: "a.rhai", half_size: 2 });
    expect(fake.requests).toEqual([]);
  });

  it("writes nothing for an invalid script", async () => {
    const { client, fake, out } = await setup();
    fake.handler = scratchcadError(422, "script_error", "script error: oops (line 1, position 2)");
    expect(await callError(client, "save_script", { script: "let", path: "bad.rhai" })).toBe(
      "script_error: script error: oops (line 1, position 2)",
    );
    expect(fs.existsSync(path.join(out, "bad.rhai"))).toBe(false);
  });

  it("refuses to overwrite by default", async () => {
    const { client, fake, out } = await setup();
    const target = path.join(out, "a.rhai");
    fs.writeFileSync(target, "// mine\n");
    expect(await callError(client, "save_script", { script: SCRIPT, path: "a.rhai" })).toContain(
      "already exists",
    );
    expect(fake.requests).toEqual([]);
    await call(client, "save_script", { script: SCRIPT, path: "a.rhai", overwrite: true });
    expect(fs.readFileSync(target, "utf8")).toContain(SCRIPT);
  });

  it.each([
    ["../a.rhai", "inside the output directory"],
    ["a.stl", "end in .rhai"],
    ["", "empty"],
  ])("rejects the path '%s'", async (target, message) => {
    const { client, fake } = await setup();
    expect(await callError(client, "save_script", { script: SCRIPT, path: target })).toContain(
      message,
    );
    expect(fake.requests).toEqual([]);
  });

  it("reads a script", async () => {
    const { client, fake, out } = await setup();
    const text = `// region: center=[0, -1, 0] half_size=4\n${SCRIPT}\n`;
    fs.writeFileSync(path.join(out, "a.rhai"), text);
    const result = await call(client, "read_script", { path: "a.rhai" });
    expect(result.structuredContent).toEqual({ path: path.join(out, "a.rhai"), script: text });
    expect(fake.requests).toEqual([]);
  });

  it("explains read errors", async () => {
    const { client, out } = await setup();
    fs.writeFileSync(path.join(out, "binary.rhai"), Buffer.from([0xff, 0xfe]));
    expect(await callError(client, "read_script", { path: "binary.rhai" })).toContain("not UTF-8");
    expect(await callError(client, "read_script", { path: "nope.rhai" })).toContain(
      "does not exist",
    );
    expect(await callError(client, "read_script", { path: "a.stl" })).toContain("end in .rhai");
  });
});

describe("errors shared by every tool", () => {
  it.each([
    ["validate_script", {}],
    ["render_2d", {}],
    ["render_3d", {}],
    ["export", { path: "x.stl" }],
    ["save_script", { path: "x.rhai" }],
  ])("%s reports an unreachable server", async (tool, args) => {
    const settings = testSettings();
    const fake = new FakeScratchcad();
    fake.handler = () => {
      throw Object.assign(new Error("connect ECONNREFUSED"), { code: "ECONNREFUSED" });
    };
    const client = await connect(settings, fake);
    const text = await callError(client, tool, { script: SCRIPT, ...args });
    expect(text).toMatch(/could not reach scratchcad at http:\/\/scratchcad\.test .*running/);
  });

  it("masks unexpected errors", async () => {
    const { client, fake } = await setup();
    fake.handler = () => response(200, "not json");
    const errors: unknown[] = [];
    const original = console.error;
    console.error = (...args: unknown[]) => errors.push(args);
    try {
      const text = await callError(client, "validate_script", { script: SCRIPT });
      expect(text).toBe("Error calling tool: an internal error occurred");
      expect(text).not.toContain("JSON");
      expect(errors).toHaveLength(1);
    } finally {
      console.error = original;
    }
  });
});
