// Casement window stay arm: 250 mm flat bar 15 x 4 mm, 5 peg holes 6 mm every 30 mm, pivot boss 12 mm, rounded tip
let length = 250.0; // [150.0, 350.0] Stay length (mm)
let width = 15.0; // [10.0, 20.0] Bar width (mm)
let t = 4.0; // [3.0, 6.0] Bar thickness (mm)
let bar = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, t]);
let b = bar.fillet(width / 2.0 - 0.5, bar.edges("|Z"));
let boss = cylinder(8.0, t + 2.0);
let holes = [cylinder([0, 0, -1], "Z", 3.0, t + 4.0)];
for k in 0..5 { holes.push(cylinder([length - 20.0 - k.to_float() * 30.0, 0, -1], "Z", 3.0, t + 2.0)); }
b + boss - compound(holes)
