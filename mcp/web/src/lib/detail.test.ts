import { describe, expect, it } from "vitest";
import { DETAILS, EXPORT_DETAIL, PREVIEW_DETAIL, toleranceFor } from "./detail";

describe("toleranceFor", () => {
  it("scales with the bounding box's diagonal", () => {
    expect(toleranceFor(1, [30, 40, 0])).toBe(0.05);
    expect(toleranceFor(0, [30, 40, 0])).toBe(0.2);
    expect(toleranceFor(3, [3, 4, 12])).toBe(0.0013);
  });

  it("rounds to three significant figures", () => {
    expect(toleranceFor(1, [1, 1, 1])).toBe(0.00173);
  });

  it("leaves the tolerance to scratchcad without a size", () => {
    expect(toleranceFor(1, null)).toBeUndefined();
    expect(toleranceFor(1, [0, 0, 0])).toBeUndefined();
    expect(toleranceFor(99, [1, 1, 1])).toBeUndefined();
  });

  it("gets finer level by level, and previews coarser than exports", () => {
    const fractions = DETAILS.map((d) => d.fraction);
    expect([...fractions].sort((a, b) => b - a)).toEqual(fractions);
    expect(DETAILS[PREVIEW_DETAIL]!.fraction).toBeGreaterThan(DETAILS[EXPORT_DETAIL]!.fraction);
    // Never finer than scratchcad allows (1e-5 of the diagonal)
    expect(Math.min(...fractions)).toBeGreaterThanOrEqual(1e-5);
  });
});
