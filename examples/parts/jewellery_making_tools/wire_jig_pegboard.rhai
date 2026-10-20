// Wire wrapping jig: 80 x 80 x 6 mm board with a 9 x 9 grid of 2.5 mm peg holes on 8 mm pitch, 4 rubber feet
let size = 80.0; // [60.0, 120.0] Board size (mm)
let t = 6.0; // [4.0, 10.0] Thickness (mm)
let pitch = 8.0; // [5.0, 12.0] Hole pitch (mm)
let board = box_centered(size, size, t).translate([0, 0, t / 2.0]);
let b = board.fillet(5.0, board.edges("|Z"));
let holes = [];
let n = ((size - 10.0) / pitch).floor().to_int();
for i in 0..=n { for j in 0..=n { holes.push(cylinder([-n.to_float() * pitch / 2.0 + i.to_float() * pitch, -n.to_float() * pitch / 2.0 + j.to_float() * pitch, 1.0], "Z", 1.25, t)); } }
let feet = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { feet.push(cylinder([sx * (size / 2.0 - 7.0), sy * (size / 2.0 - 7.0), -1], "Z", 4.0, 1.6)); } }
b - compound(holes) - compound(feet)
