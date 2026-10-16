// Mesh detail: how closely the preview and exported meshes follow the part's
// surface, as a fraction of its bounding box's diagonal, so a setting means
// the same for a bolt and a bridge. scratchcad takes an absolute tolerance;
// the editor works it out from the size the script's shape reports.

export interface Detail {
  label: string;
  /** The tolerance as a fraction of the bounding box's diagonal. */
  fraction: number;
}

export const DETAILS: Detail[] = [
  { label: "Coarse", fraction: 4e-3 },
  // scratchcad's own default for mesh exports
  { label: "Normal", fraction: 1e-3 },
  { label: "Fine", fraction: 2.5e-4 },
  { label: "Very fine", fraction: 1e-4 },
];
export const PREVIEW_DETAIL = 1;
export const EXPORT_DETAIL = 2;

/**
 * The tolerance for a detail level and a bounding box `size`, to three
 * significant figures; undefined (scratchcad's default) for a shape with no
 * size, or an unknown level.
 */
export function toleranceFor(detail: number, size: number[] | null): number | undefined {
  const fraction = DETAILS[detail]?.fraction;
  if (fraction === undefined || size === null) return undefined;
  const diagonal = Math.hypot(...size);
  if (!(diagonal > 0)) return undefined;
  return Number((fraction * diagonal).toPrecision(3));
}
