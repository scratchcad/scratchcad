/** The script a new file starts with: small, valid, and showing the conventions. */
export const NEW_SCRIPT = `// A plate with rounded corners and a hole through it.
// Drag the sliders, or edit the script.
// # Plate
let width = 40.0; // [20, 80] Width (mm)
let depth = 30.0; // [20, 60] Depth (mm)
let thickness = 6.0; // [2, 20] Thickness (mm)
let corner = 4.0; // [0.5, 8] Corner radius (mm)
// # Hole
let hole = 5.0; // [1, 8] Hole radius (mm)

let plate = box_centered(width, depth, thickness).fillet(corner, "|Z");
plate - cylinder([0, 0, -thickness], "Z", hole, 2.0 * thickness)
`;
