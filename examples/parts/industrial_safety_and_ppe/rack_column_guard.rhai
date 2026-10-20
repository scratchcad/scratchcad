// Pallet racking column guard: wrap-around U guard 400 mm tall for a 100 x 75 mm upright, 8 mm wall, 50 mm clearance, 45 degree corner chamfers, 120 mm bolt-down foot with four 14 mm anchor holes
let column_width = 100.0; // [80.0, 130.0] Upright width (mm)
let column_depth = 75.0; // [60.0, 120.0] Upright depth (mm)
let height = 400.0; // [200.0, 800.0] Guard height (mm)
let wall = 8.0; // [5.0, 12.0] Wall thickness (mm)
const gap = 25.0;
let iw = column_width + 2.0 * gap;
let id = column_depth + gap;
let ow = iw + 2.0 * wall;
let od = id + wall;
let outer = polygon("XY", [[-ow / 2.0, 0], [ow / 2.0, 0], [ow / 2.0, od - 30.0], [ow / 2.0 - 30.0, od], [-ow / 2.0 + 30.0, od], [-ow / 2.0, od - 30.0]]).to_face().extrude([0, 0, height]);
let inner = polygon("XY", [[-iw / 2.0, -1.0], [iw / 2.0, -1.0], [iw / 2.0, id - 25.0], [iw / 2.0 - 25.0, id], [-iw / 2.0 + 25.0, id], [-iw / 2.0, id - 25.0]]).to_face().extrude([0, 0, height + 2.0]).translate([0, 0, -1.0]);
let feet = box_from_corners([-ow / 2.0 - 60.0, od - 120.0, 0], [ow / 2.0 + 60.0, od, wall]);
let holes = [];
for sx in [-1.0, 1.0] { for y in [od - 95.0, od - 25.0] { holes.push(cylinder([sx * (ow / 2.0 + 30.0), y, -1.0], "Z", 7.0, wall + 2.0)); } }
(outer - inner + feet) - compound(holes)
