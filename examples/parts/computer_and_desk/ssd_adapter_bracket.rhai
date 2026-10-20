// 2.5 to 3.5 in drive adapter bracket: 101.6 x 146 mm footprint, 1 mm steel, 2.5 in M3 bottom holes
let width = 101.6; // [100.0, 102.0] 3.5 in drive width (mm)
let length = 120.0; // [100.0, 146.0] Bracket length (mm)
let t = 1.2; // [1.0, 2.0] Sheet thickness (mm)
let wall_h = 12.0; // [8.0, 20.0] Side wall height (mm)
let base = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, length, t]);
let walls = box_from_corners([-width / 2.0, 0, 0], [-width / 2.0 + t, length, wall_h]) + box_from_corners([width / 2.0 - t, 0, 0], [width / 2.0, length, wall_h]);
let side_holes = [];
for y in [28.5, 70.0, 101.6] { side_holes.push(cylinder([-width / 2.0 - 1.0, y, 6.35], "X", 1.6, width + 2.0)); }
let ssd_holes = [];
for x in [-34.93, 34.93] { for y in [20.0, 96.6] { ssd_holes.push(cylinder([x, y, -1], "Z", 1.6, t + 2.0)); } }
let window = box_from_corners([-25.0, 30.0, -1], [25.0, 85.0, t + 1.0]);
base + walls - compound(side_holes) - compound(ssd_holes) - window
