// Pantograph link bar: 150 mm, 5 holes every 25 mm for 4 mm pins, 12 x 4 mm with rounded ends
let length = 150.0; // [80.0, 300.0] Length (mm)
let spacing = 25.0; // [10.0, 50.0] Hole spacing (mm)
let width = 12.0; // [8.0, 20.0] Width (mm)
let t = 4.0; // [2.0, 8.0] Thickness (mm)
let bar = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, t]) + cylinder(width / 2.0, t) + cylinder([length, 0, 0], "Z", width / 2.0, t);
let holes = [cylinder([0, 0, -1], "Z", 2.0, t + 2.0), cylinder([length, 0, -1], "Z", 2.0, t + 2.0)];
let n = (length / spacing).floor().to_int();
for k in 1..n { holes.push(cylinder([k.to_float() * spacing, 0, -1], "Z", 2.0, t + 2.0)); }
bar - compound(holes)
