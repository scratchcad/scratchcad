// Cocktail muddler: 230 mm, 25 mm toothed head with 9 teeth 8 mm, 20 mm grip tapering to 14 mm
let length = 230.0; // [180.0, 300.0] Length (mm)
let head = 25.0; // [18.0, 35.0] Head diameter (mm)
let grip = 20.0; // [15.0, 28.0] Grip diameter (mm)
let p = sketch("XZ").move_to(0, 0).hline_to(head / 2.0).vline_to(25.0).line_to(7.0, 60.0).line_to(grip / 2.0, length - 40.0).arc_to(grip / 2.0 + 1.0, length - 20.0, grip / 2.0 - 2.0, length).hline_to(0).close();
let body = p.face().revolve("Z", 360);
let teeth = [];
for i in -1..=1 { for j in -1..=1 { teeth.push(box_centered(4.0, 4.0, 8.0).translate([i.to_float() * 7.0, j.to_float() * 7.0, 0])); } }
body + (fuse_all(teeth).translate([0, 0, -3.99]) & cylinder([0, 0, -10.0], "Z", head / 2.0 - 0.5, 20.0))
