// The scratchcad service, reached through scratchcad-mcp's /api/scratchcad
// proxy, which adds the API token (if there is one) so the page never sees it.
import type { Format } from "../../../src/shared/formats.ts";
import { errorFrom } from "./errors";

const BASE = "/api/scratchcad/v1";

/**
 * What scratchcad reports about the shape a script builds. The editor leaves out the volume,
 * area and center, which it never shows and which take the longest to measure.
 */
export interface ShapeSummary {
  type: string;
  solids: number;
  faces: number;
  edges: number;
  vertices: number;
  valid: boolean;
  bounding_box: { min: number[]; max: number[]; size: number[] };
}

export interface Validated {
  shape: ShapeSummary;
  output: string[];
  warnings: string[];
  scriptMs: number;
}

/** An exported file: a mesh for the preview, or any format for saving. */
export interface Exported {
  data: ArrayBuffer;
  /** Mesh formats only. */
  triangles: number | null;
  tolerance: number | null;
  computeMs: number | null;
  warnings: string[];
}

async function post(path: string, body: unknown, signal?: AbortSignal): Promise<Response> {
  const response = await fetch(`${BASE}${path}`, {
    method: "POST",
    headers: { "content-type": "application/json" },
    body: JSON.stringify(body),
    signal,
  });
  if (!response.ok) throw await errorFrom(response);
  return response;
}

export async function validate(script: string, signal?: AbortSignal): Promise<Validated> {
  const response = await post("/scripts/validate", { script, mass_properties: false }, signal);
  const body = (await response.json()) as Omit<Validated, "scriptMs"> & { script_ms: number };
  return {
    shape: body.shape,
    output: body.output,
    warnings: body.warnings,
    scriptMs: body.script_ms,
  };
}

/**
 * The shape as a file. `tolerance` applies to mesh formats (STL, OBJ, 3MF);
 * leave it unset for scratchcad's default.
 */
export async function exportShape(
  format: Format,
  request: { script: string; tolerance?: number },
  signal?: AbortSignal,
): Promise<Exported> {
  const response = await post(`/export/${format}`, request, signal);
  const number = (name: string) => {
    const value = response.headers.get(name);
    return value === null ? null : Number(value);
  };
  // The proxy sends the warnings as one JSON array (see src/app.ts).
  const warnings = response.headers.get("x-warnings");
  return {
    data: await response.arrayBuffer(),
    triangles: number("x-triangle-count"),
    tolerance: number("x-mesh-tolerance"),
    computeMs: number("x-compute-ms"),
    warnings: warnings ? (JSON.parse(warnings) as string[]) : [],
  };
}
