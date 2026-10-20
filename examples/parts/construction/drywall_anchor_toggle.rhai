// Plastic drywall toggle anchor for 12.7 mm board: 10 mm shank 38 mm long split into two wings, 14 mm collar with grip ribs, 4.5 mm screw bore
let board = 12.7; // [9.5, 16.0] Board thickness (mm)
let a = cylinder([0, 0, 0], "Z", 5.0, 38.0) + cylinder([0, 0, -1.0], "Z", 7.0, 1.0);
for k in 0..4 { a += box_centered(1.0, 2.0, board - 2.0).translate([5.0, 0, board / 2.0]).rotate_z(k.to_float() * 90.0); }
a - cylinder([0, 0, -2.0], "Z", 2.25, 42.0) - box_centered(12.0, 1.2, 22.0).translate([0, 0, board + 14.0])
