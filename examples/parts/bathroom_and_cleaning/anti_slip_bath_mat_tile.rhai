// Anti-slip bath mat tile: 100 x 100 x 4 mm, 5 x 5 drain holes 6 mm, 4 x 4 grip bumps 4 mm, 4 suction cups 20 mm underneath
let size = 100.0; // [70.0, 150.0] Tile size (mm)
let t = 4.0; // [3.0, 6.0] Tile thickness (mm)
let hole_d = 6.0; // [3.0, 10.0] Drain hole diameter (mm)
let cup_d = 20.0; // [14.0, 28.0] Suction cup diameter (mm)
let tile = box_centered(size, size, t).translate([0, 0, t / 2.0]);
let tl = tile.fillet(8.0, tile.edges("|Z"));
let p = size / 5.0;
let holes = [];
for i in 0..5 { for j in 0..5 { holes.push(cylinder([(i.to_float() - 2.0) * p, (j.to_float() - 2.0) * p, -1], "Z", hole_d / 2.0, t + 2.0)); } }
let bumps = [];
for i in 0..4 { for j in 0..4 { bumps.push(sphere([(i.to_float() - 1.5) * p, (j.to_float() - 1.5) * p, t], 2.0)); } }
let cups = [];
let cr = cup_d / 2.0;
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] {
    let c = [sx * p * 1.5, sy * p * 1.5, 0];
    cups.push(cone(cr, cr * 0.5, 4.0).translate([c[0], c[1], -4.0]) + cylinder([c[0], c[1], -0.5], "Z", cr * 0.5, 1.0) - cone(cr - 1.0, 2.0, 3.6).translate([c[0], c[1], -4.5]));
} }
tl + compound(bumps) + compound(cups) - compound(holes)
