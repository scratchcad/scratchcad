// Caravan gas locker drop vent: 120 x 60 mm grille with 5 mm frame, 15 mm spigot depth, 2.5 mm bars on 6 mm centres running across, and a 10 mm flange with 4 screw holes
let width = 120.0; // [80.0, 160.0] Vent opening width (mm)
let height = 60.0; // [40.0, 90.0] Vent opening height (mm)
const flange = 10.0;
let frame = box_from_corners([-width / 2.0, -height / 2.0, 0], [width / 2.0, height / 2.0, 15.0]) - box_from_corners([-width / 2.0 + 2.0, -height / 2.0 + 2.0, -1.0], [width / 2.0 - 2.0, height / 2.0 - 2.0, 16.0]);
let face_ = box_from_corners([-width / 2.0 - flange, -height / 2.0 - flange, 0], [width / 2.0 + flange, height / 2.0 + flange, 3.0]);
let open = box_from_corners([-width / 2.0 + 3.0, -height / 2.0 + 3.0, -1.0], [width / 2.0 - 3.0, height / 2.0 - 3.0, 4.0]);
let n = ((width - 6.0) / 6.0).to_int();
let bars = [];
for i in 1..n { bars.push(box_from_corners([-width / 2.0 + 3.0 + i.to_float() * 6.0 - 1.25, -height / 2.0 + 2.5, 0], [-width / 2.0 + 3.0 + i.to_float() * 6.0 + 1.25, height / 2.0 - 2.5, 3.0])); }
let holes = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * (width / 2.0 + 5.0), sy * (height / 2.0 + 5.0), -1.0], "Z", 2.0, 5.0)); } }
frame + (face_ - open) + fuse_all(bars) - fuse_all(holes)
