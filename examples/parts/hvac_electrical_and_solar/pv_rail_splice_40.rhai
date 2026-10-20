// Internal splice for a 40 x 40 mm aluminium PV mounting rail: 150 mm long U channel 34 x 30 mm, 3 mm walls, four 6.5 mm self-tapping screw holes in each side, centre stop tab
let length = 150.0; // [100.0, 250.0] Splice length (mm)
let width = 34.0; // [24.0, 40.0] Channel width (mm)
let height = 30.0; // [20.0, 40.0] Channel height (mm)
let hole_d = 6.5; // [4.0, 8.5] Screw hole diameter (mm)
const t = 3.0;
let u = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, height]) - box_from_corners([-1, -width / 2.0 + t, t], [length + 1.0, width / 2.0 - t, height + 1.0]);
u = u.chamfer(1.0, "|Y and (<X or >X)");
let tab = box_from_corners([length / 2.0 - 1.5, -width / 2.0 - 3.0, height - 8.0], [length / 2.0 + 1.5, -width / 2.0 + 0.1, height]);
u = u + tab + tab.mirror([length / 2.0, 0, 0], [0, 1, 0]);
for x in [15.0, 45.0, length - 45.0, length - 15.0] {
    u -= cylinder([x, -width, height / 2.0], "Y", hole_d / 2.0, 2.0 * width);
}
u
