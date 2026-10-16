import { describe, expect, it } from "vitest";
import { EXPORT_EXTENSIONS, FORMAT_INFO, FORMATS, formatOf } from "../src/shared/formats.ts";

describe("formats", () => {
  it.each([
    ["part.step", "step"],
    ["dir.v2/PART.STP", "step"],
    ["a.igs", "iges"],
    ["a.brep", "brep"],
    ["a.stl", "stl"],
    ["a.obj", "obj"],
    ["a.3mf", "3mf"],
    ["a.rhai", null],
    ["no-extension", null],
  ])("%s is %s", (path, format) => {
    expect(formatOf(path)).toBe(format);
  });

  it("lists every extension once, the usual one first", () => {
    expect(EXPORT_EXTENSIONS).toEqual([
      ".step", ".stp", ".iges", ".igs", ".brep", ".brp", ".stl", ".obj", ".3mf",
    ]); // prettier-ignore
    for (const format of FORMATS) {
      expect(FORMAT_INFO[format].extensions[0]).toBe(`.${format}`);
    }
    expect(FORMATS.filter((f) => FORMAT_INFO[f].mesh)).toEqual(["stl", "obj", "3mf"]);
  });
});
