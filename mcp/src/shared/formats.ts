// The formats scratchcad exports: the file extensions they are saved with,
// their content types, and whether they hold a triangle mesh (which takes a
// tolerance) or exact geometry. The MCP server (path rules, the export tool,
// the file API) and the editor (its export picker) share this module.

export const FORMATS = ["step", "iges", "brep", "stl", "obj", "3mf"] as const;
export type Format = (typeof FORMATS)[number];

export interface FormatInfo {
  /** The name people know it by, e.g. "STEP". */
  label: string;
  /** File extensions, the usual one first. */
  extensions: string[];
  contentType: string;
  /** A triangle mesh, rather than exact B-rep geometry. */
  mesh: boolean;
  /** What it is for, in a few words. */
  use: string;
}

export const FORMAT_INFO: Record<Format, FormatInfo> = {
  step: {
    label: "STEP",
    extensions: [".step", ".stp"],
    contentType: "model/step",
    mesh: false,
    use: "exact geometry for CAD programs",
  },
  iges: {
    label: "IGES",
    extensions: [".iges", ".igs"],
    contentType: "model/iges",
    mesh: false,
    use: "exact geometry for older CAD programs",
  },
  brep: {
    label: "BREP",
    extensions: [".brep", ".brp"],
    contentType: "application/octet-stream",
    mesh: false,
    use: "OpenCASCADE's own exact format",
  },
  stl: {
    label: "STL",
    extensions: [".stl"],
    contentType: "model/stl",
    mesh: true,
    use: "a triangle mesh for 3D printing",
  },
  obj: {
    label: "OBJ",
    extensions: [".obj"],
    contentType: "model/obj",
    mesh: true,
    use: "a triangle mesh for 3D tools",
  },
  "3mf": {
    label: "3MF",
    extensions: [".3mf"],
    contentType: "model/3mf",
    mesh: true,
    use: "a triangle mesh in millimetres for 3D printing",
  },
};

/** Every extension an export may be saved with, dot included. */
export const EXPORT_EXTENSIONS = FORMATS.flatMap((f) => FORMAT_INFO[f].extensions);

/** The format a file name's extension names (case-insensitive), or null. */
export function formatOf(path: string): Format | null {
  const dot = path.lastIndexOf(".");
  if (dot === -1) return null;
  const extension = path.slice(dot).toLowerCase();
  return FORMATS.find((f) => FORMAT_INFO[f].extensions.includes(extension)) ?? null;
}
