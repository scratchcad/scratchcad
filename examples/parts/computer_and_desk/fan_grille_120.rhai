// 120 mm case fan grille: 120 x 120 x 2 mm, 105 mm M4 hole pattern, concentric rings with 4 spokes
let size = 120.0; // [80.0, 140.0] Fan size (mm)
let pitch = 105.0; // [71.5, 124.5] Hole spacing (mm)
let thickness = 2.0; // [1.5, 3.0] Thickness (mm)
let plate = box_centered(size, size, thickness);
let p = plate.fillet(6.0, plate.edges("|Z"));
let opening = cylinder([0, 0, -2], "Z", size / 2.0 - 3.0, 4.0);
let rings = [];
let n = ((size / 2.0 - 8.0) / 8.0).floor().to_int();
for k in 1..=n { rings.push(cylinder([0, 0, -thickness / 2.0], "Z", k.to_float() * 8.0 + 1.0, thickness) - cylinder([0, 0, -2], "Z", k.to_float() * 8.0 - 1.0, 4.0)); }
let spokes = [];
for k in 0..4 { spokes.push(box_centered(size - 6.0, 2.0, thickness).rotate_z(k.to_float() * 45.0)); }
let holes = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * pitch / 2.0, sy * pitch / 2.0, -2], "Z", 2.2, 4.0)); } }
let grid = fuse_all(rings + spokes) & cylinder([0, 0, -2], "Z", size / 2.0 - 2.0, 4.0);
(p - opening) + grid - compound(holes)
