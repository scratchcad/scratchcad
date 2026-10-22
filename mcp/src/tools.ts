// The MCP tools: the scratchcad API, plus saving and reading scripts and
// writing exports in the local output directory.
import fs from "node:fs";
import { type CallToolResult, McpServer } from "@modelcontextprotocol/server";
import { z } from "zod";
import { type BinaryResult, type Body, ScratchcadClient, ScratchcadError } from "./client.ts";
import { GUIDE } from "./guide.ts";
import { EXPORT_EXTENSIONS, FORMAT_INFO, FORMATS, formatOf } from "./shared/formats.ts";
import { checkParams, parseParams } from "./shared/params.ts";
import * as workspace from "./workspace.ts";
import { SCRIPT, WorkspaceError } from "./workspace.ts";

export interface ToolOptions {
  client: ScratchcadClient;
  outputDir: string;
  /** Where the editor is served, if it is; save_script links scripts to it. */
  editorUrl: string | null;
  version: string;
}

/** A failure the model should see verbatim (anything else is masked). */
export class ToolError extends Error {
  override name = "ToolError";
}

const script = z
  .string()
  .describe("Rhai script that builds the shape. See the server instructions.");
const vec3 = z.tuple([z.number(), z.number(), z.number()]);
const halfSize = z
  .number()
  .gt(0)
  .optional()
  .describe(
    "Half the width of the view along the image's longer side. Leave unset to fit the part.",
  );
const pixels = z.number().int().min(1).describe("Image size in pixels.");
const meshFormats = FORMATS.filter((f) => FORMAT_INFO[f].mesh);

const readOnly = { readOnlyHint: true, idempotentHint: true, openWorldHint: false };
const writing = { readOnlyHint: false, destructiveHint: true };

const missingMass =
  "Left out, with a warning saying why, when the shape can't be measured exactly.";
const shapeSummary = z
  .looseObject({
    type: z.string().describe("solid, compound, shell, face, wire, edge or vertex."),
    solids: z.number().int(),
    faces: z.number().int(),
    edges: z.number().int(),
    vertices: z.number().int(),
    valid: z.boolean().describe("Whether OpenCASCADE's checker finds the shape valid."),
    bounding_box: z.looseObject({ min: vec3, max: vec3, size: vec3 }),
    volume: z.number().optional().describe(missingMass),
    area: z.number().optional().describe(missingMass),
    center: vec3.optional().describe(`Center of mass. ${missingMass}`),
  })
  .describe("What the script built.");
const shapeWarnings = z
  .array(z.string())
  .describe("Problems with the shape that will cause trouble, such as having no solids.");

const validated = z.looseObject({
  shape: shapeSummary,
  output: z.array(z.string()).describe("What the script printed with print() and debug()."),
  warnings: shapeWarnings,
  script_ms: z.number(),
  measure_ms: z.number(),
});

const exported = z.object({
  path: z.string().describe("Absolute path of the written file."),
  format: z.enum(FORMATS),
  bytes: z.number().int(),
  triangles: z.number().int().nullable().describe("Triangles in a mesh format; null otherwise."),
  tolerance: z
    .number()
    .nullable()
    .describe("The mesh tolerance used, for mesh formats; null otherwise."),
  compute_ms: z.number().nullable(),
  warnings: z
    .array(z.string())
    .describe("Observations that did not stop the export, such as a mesh that isn't watertight."),
});

const savedScript = z.object({
  path: z.string().describe("Absolute path of the written .rhai file."),
  bytes: z.number().int(),
  shape: shapeSummary,
  warnings: shapeWarnings,
  editor_url: z
    .string()
    .nullable()
    .describe("Link that opens the script in the editor; null when the editor is not running."),
  parameters: z
    .array(
      z.object({
        name: z.string(),
        label: z.string(),
        section: z.string(),
        value: z.number(),
        min: z.number(),
        max: z.number(),
      }),
    )
    .describe("The sliders the editor shows for this script, in order."),
  notes: z
    .array(z.string())
    .describe(
      "Problems with the parameters that make the sliders hard to use. Fix them and save again.",
    ),
});

const scriptFile = z.object({
  path: z.string().describe("Absolute path of the .rhai file."),
  script: z.string().describe("The file's text."),
});

/** Leave unset options out of the request so the server applies its defaults. */
function dropUndefined(body: Body): Body {
  return Object.fromEntries(Object.entries(body).filter(([, value]) => value !== undefined));
}

function structured<T extends Record<string, unknown>>(value: T): CallToolResult {
  return { content: [{ type: "text", text: JSON.stringify(value) }], structuredContent: value };
}

/**
 * The rendered PNG, then the view it shows (so a follow-up render can keep or
 * adjust it), then a text block for each warning.
 */
function image(result: BinaryResult): CallToolResult {
  const view = result.view && {
    type: "text" as const,
    text:
      `View: center=${JSON.stringify(result.view.center)} half_size=${result.view.halfSize}. ` +
      "Pass them back to keep this framing, or a smaller half_size to zoom in.",
  };
  return {
    content: [
      { type: "image", data: result.data.toString("base64"), mimeType: "image/png" },
      ...(view ? [view] : []),
      ...result.warnings.map((w) => ({ type: "text" as const, text: `Warning: ${w}` })),
    ],
  };
}

/**
 * Runs a tool body, turning expected failures into tool errors the model can
 * act on, and hiding the details of anything unexpected.
 */
async function guard(run: () => Promise<CallToolResult>): Promise<CallToolResult> {
  try {
    return await run();
  } catch (error) {
    const expected =
      error instanceof ToolError ||
      error instanceof ScratchcadError ||
      error instanceof WorkspaceError;
    if (!expected) console.error("scratchcad-mcp: unexpected error in a tool:", error);
    const text = expected ? error.message : "Error calling tool: an internal error occurred";
    return { content: [{ type: "text", text }], isError: true };
  }
}

/** Where a tool may write `relative`, or a ToolError saying why it may not. */
function writable(outputDir: string, relative: string, suffixes: string[], overwrite: boolean) {
  const target = workspace.resolve(outputDir, relative, suffixes);
  if (fs.existsSync(target) && !overwrite) {
    throw new ToolError(`${target} already exists; pass overwrite=true to replace it`);
  }
  return target;
}

export function createMcpServer({ client, outputDir, editorUrl, version }: ToolOptions): McpServer {
  const server = new McpServer({ name: "scratchcad", version }, { instructions: GUIDE });

  server.registerTool(
    "validate_script",
    {
      description:
        "Run a script and describe the shape it builds, without rendering it.\n\nReturns the " +
        "shape's type, its solid, face, edge and vertex counts, whether it is valid, its " +
        "bounding box, volume, area and center of mass, anything the script printed, and " +
        "warnings. Errors include the line and column. Use it to check dimensions exactly.",
      inputSchema: z.strictObject({ script }),
      outputSchema: validated,
      annotations: readOnly,
    },
    (args) => guard(async () => structured(await client.validate({ script: args.script }))),
  );

  server.registerTool(
    "render_2d",
    {
      description:
        "Render the cross-section at z = 0 as a PNG, looking down the Z axis with +X right " +
        "and +Y up.\n\nUse it to see inside a part: holes, wall thickness and internal " +
        "features. A part resting on the XY plane shows the outline of its base. To slice " +
        "elsewhere, translate the shape in the script. The view fits the part unless center " +
        "and half_size are given.",
      inputSchema: z.strictObject({
        script,
        width: pixels.default(512),
        height: pixels.default(512),
        mode: z
          .enum(["mono", "outline"])
          .default("mono")
          .describe("mono fills the section white on black; outline draws only its edges."),
        center: z
          .tuple([z.number(), z.number()])
          .optional()
          .describe("Model-space [x, y] at the image center. Leave unset to fit the part."),
        half_size: halfSize,
      }),
      annotations: readOnly,
    },
    (args) => guard(async () => image(await client.raster2d(dropUndefined(args)))),
  );

  server.registerTool(
    "render_3d",
    {
      description:
        "Render a shaded 3D view of the shape as a PNG with a transparent background, with " +
        "its sharp edges drawn.\n\nThe angles compose like this: with all three at 0 the camera " +
        "looks straight down the Z axis (+Y up on screen). pitch then tips it toward the " +
        "horizon: 90 is a front view from -Y with +Z up. roll then turns the camera around " +
        "the part's Z axis: 90 views it from +X. yaw turns about the Y axis and is rarely " +
        "needed. The default looks from the front right, slightly above. Render several " +
        "angles to check a part from all sides. The view fits the part unless center and " +
        "half_size are given.",
      inputSchema: z.strictObject({
        script,
        width: pixels.default(512),
        height: pixels.default(512),
        pitch: z
          .number()
          .default(65)
          .describe("Degrees: 0 looks down from +Z, 90 is level, 180 looks up from below."),
        roll: z
          .number()
          .default(30)
          .describe("Degrees around the part's Z axis: 0 from the front (-Y), 90 from +X."),
        yaw: z.number().default(0).describe("Degrees about the Y axis, applied last."),
        center: vec3
          .optional()
          .describe("Model-space point at the middle of the view. Leave unset to fit the part."),
        half_size: halfSize,
        mode: z
          .enum(["shaded", "normals", "heightmap"])
          .default("shaded")
          .describe(
            "shaded is lit; normals colours each surface by its direction; heightmap is " +
              "brighter where nearer.",
          ),
        edges: z
          .boolean()
          .default(true)
          .describe("Draw the sharp edges as dark lines (shaded and normals modes)."),
        perspective: z.number().min(0).max(1).default(0).describe("0 is orthographic, up to 1."),
      }),
      annotations: readOnly,
    },
    ({ yaw, pitch, roll, ...args }) =>
      guard(async () =>
        image(await client.raster3d(dropUndefined({ ...args, rotation: { yaw, pitch, roll } }))),
      ),
  );

  server.registerTool(
    "export",
    {
      description:
        "Export the shape to a file in the output directory. The path's extension picks the " +
        "format: " +
        FORMATS.map((f) => `${FORMAT_INFO[f].extensions.join("/")} (${FORMAT_INFO[f].use})`).join(
          ", ",
        ) +
        ".\n\nCoordinates are model units, read as millimetres by most programs. Mesh formats " +
        "(.stl, .obj, .3mf) are watertight for solids.",
      inputSchema: z.strictObject({
        script,
        path: z
          .string()
          .describe(
            "Where to write the file, relative to the output directory " +
              "(SCRATCHCAD_MCP_OUTPUT_DIR). It cannot leave that directory.",
          ),
        tolerance: z
          .number()
          .gt(0)
          .optional()
          .describe(
            "Mesh formats only: the largest distance between the mesh and the true surface, " +
              "in model units. Defaults to 1/1000 of the bounding box's diagonal.",
          ),
        overwrite: z.boolean().default(false).describe("Replace the file if it already exists."),
      }),
      outputSchema: exported,
      annotations: writing,
    },
    ({ path, overwrite, ...args }) =>
      guard(async () => {
        const target = writable(outputDir, path, EXPORT_EXTENSIONS, overwrite);
        const format = formatOf(target)!;
        if (args.tolerance !== undefined && !FORMAT_INFO[format].mesh) {
          throw new ToolError(
            `tolerance only applies to mesh formats (${meshFormats.join(", ")}); ` +
              `${format} stores exact geometry`,
          );
        }
        const result = await client.export(format, dropUndefined(args));
        workspace.write(target, result.data);
        return structured({
          path: target,
          format,
          bytes: result.data.length,
          triangles: result.triangles,
          tolerance: result.tolerance,
          compute_ms: result.computeMs,
          warnings: result.warnings,
        });
      }),
  );

  server.registerTool(
    "save_script",
    {
      description:
        "Check the script and save it as a .rhai file the user can open in the editor.\n\n" +
        "This is how a finished part is delivered. The result describes the shape, lists the " +
        "sliders the user will see and notes on any that are unclear; fix those and save " +
        "again (overwrite=true).",
      inputSchema: z.strictObject({
        script,
        path: z
          .string()
          .describe(
            "Where to write the .rhai file, relative to the output directory " +
              "(SCRATCHCAD_MCP_OUTPUT_DIR). It cannot leave that directory.",
          ),
        overwrite: z.boolean().default(false).describe("Replace the file if it already exists."),
      }),
      outputSchema: savedScript,
      annotations: writing,
    },
    (args) =>
      guard(async () => {
        const target = writable(outputDir, args.path, [SCRIPT], args.overwrite);
        const checked = await client.validate({ script: args.script });
        const text = workspace.scriptText(args.script);
        const params = parseParams(text);
        workspace.write(target, text);
        const relative = workspace.entry(outputDir, target).path;
        return structured({
          path: target,
          bytes: Buffer.byteLength(text),
          shape: checked.shape as z.infer<typeof shapeSummary>,
          warnings: checked.warnings as string[],
          editor_url: editorUrl && `${editorUrl}?open=${encodeURIComponent(relative)}`,
          parameters: params.map(({ name, label, section, value, min, max }) => ({
            name,
            label,
            section,
            value,
            min,
            max,
          })),
          notes: checkParams(params),
        });
      }),
  );

  server.registerTool(
    "read_script",
    {
      description: "Read a saved script, including any changes the user made in the editor.",
      inputSchema: z.strictObject({
        path: z.string().describe("The .rhai file to read, relative to the output directory."),
      }),
      outputSchema: scriptFile,
      annotations: readOnly,
    },
    (args) =>
      guard(async () => {
        const target = workspace.resolve(outputDir, args.path, [SCRIPT]);
        if (!workspace.isFile(target)) throw new ToolError(`${args.path} does not exist`);
        let text: string;
        try {
          text = new TextDecoder("utf-8", { fatal: true }).decode(fs.readFileSync(target));
        } catch {
          throw new ToolError(`${args.path} is not UTF-8 text`);
        }
        return structured({ path: target, script: text });
      }),
  );

  return server;
}
