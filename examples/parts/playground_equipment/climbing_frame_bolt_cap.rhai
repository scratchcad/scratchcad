// Climbing frame bolt cover cap: 25 mm round cap 18 mm tall over an M10 nut (17 mm AF, 8 mm), 2 mm walls, snap-on with three 1 mm grip ribs inside
let af = 17.0; // [13.0, 24.0] Nut across flats (mm)
let height = 18.0; // [12.0, 25.0] Cap height (mm)
const wall = 2.0;
let r = af / cos(PI() / 6.0) / 2.0 + 0.5;
let cap = cylinder([0, 0, 0], "Z", r + wall, height);
let cap = cap.chamfer(2.0, cap.edges(">Z"));
let ribs = [];
for i in 0..3 { ribs.push(box_centered(1.5, 1.0, 6.0).translate([r - 0.5, 0, 3.0]).rotate_z(i.to_float() * 120.0)); }
cap - cylinder([0, 0, -1.0], "Z", r, height - wall + 1.0) + fuse_all(ribs)
