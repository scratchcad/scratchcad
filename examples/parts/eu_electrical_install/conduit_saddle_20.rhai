// 20 mm conduit spacer saddle: 20 mm clip, 8 mm wall standoff, 28 mm base with a 4.5 mm screw hole
let conduit = 20.0; // [16.0, 32.0] Conduit OD (mm)
let width = 12.0; // [8.0, 16.0] Saddle width (mm)
let r = conduit / 2.0;
let base = box_from_corners([-14.0 - r * 0.3, -width / 2.0, 0], [14.0 + r * 0.3, width / 2.0, 8.0]);
let clip = cylinder([0, -width / 2.0, 8.0 + r - 1.0], "Y", r + 2.0, width) - cylinder([0, -width / 2.0 - 1.0, 8.0 + r - 1.0], "Y", r, width + 2.0) - box_from_corners([-r * 0.75, -width, 8.0 + r * 1.6], [r * 0.75, width, 8.0 + 2.0 * r + 5.0]);
(base + clip) - cylinder([0, -width, 8.0 + r - 1.0], "Y", r, width * 2.0) - cylinder([-14.0, 0, -1], "Z", 2.25, 10.0)
