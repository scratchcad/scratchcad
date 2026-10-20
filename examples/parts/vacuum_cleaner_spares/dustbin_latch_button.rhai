// Vacuum dustbin release button: 25 x 15 mm cap 8 mm with a ribbed top, 2 spring posts 4 mm and a 6 mm hook 3 mm
let length = 25.0; // [18.0, 35.0] Button length (mm)
let width = 15.0; // [10.0, 20.0] Button width (mm)
let cap = box_centered(length, width, 8.0).translate([0, 0, 4.0]);
let c = cap.fillet(width / 2.0 - 0.5, cap.edges("|Z"));
let ribs = [];
for k in -2..=2 { ribs.push(box_centered(1.0, width + 2.0, 1.0).translate([k.to_float() * 3.0, 0, 8.0])); }
let posts = cylinder([-length / 2.0 + 5.0, 0, -6.0], "Z", 2.0, 6.01) + cylinder([length / 2.0 - 5.0, 0, -6.0], "Z", 2.0, 6.01);
let hook = box_from_corners([-1.5, -width / 2.0 + 2.0, -10.0], [1.5, width / 2.0 - 2.0, 0.01]) + box_from_corners([-1.5, width / 2.0 - 5.0, -10.0], [4.5, width / 2.0 - 2.0, -7.0]);
c - compound(ribs) + posts + hook
