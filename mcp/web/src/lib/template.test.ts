import { expect, it } from "vitest";
import { parseParams } from "../../../src/shared/params.ts";
import { NEW_SCRIPT } from "./template";

it("starts new scripts with slider parameters", () => {
  const params = parseParams(NEW_SCRIPT);
  expect(params.map((p) => p.name)).toEqual(["width", "depth", "thickness", "corner", "hole"]);
  expect(params.every((p) => p.ranged && p.label !== p.name)).toBe(true);
  // The no longer needed region line is gone
  expect(NEW_SCRIPT.startsWith("// region:")).toBe(false);
  const max = Object.fromEntries(params.map((p) => [p.name, p.max]));
  const min = Object.fromEntries(params.map((p) => [p.name, p.min]));
  // The largest hole leaves a wall in the narrowest plate, and the largest
  // corner fits it
  expect(2 * max.hole!).toBeLessThan(min.width!);
  expect(2 * max.hole!).toBeLessThan(min.depth!);
  expect(2 * max.corner!).toBeLessThan(min.depth!);
});
