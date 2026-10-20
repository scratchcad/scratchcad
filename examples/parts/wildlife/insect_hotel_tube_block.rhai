// Insect hotel nesting block: 100 x 100 x 120 mm with 25 holes 4 to 10 mm diameter 100 mm deep, back closed
let size = 100.0; // [80.0, 150.0] Block face size (mm)
let depth = 120.0; // [80.0, 160.0] Block depth (mm)
let b = box_from_corners([0, 0, 0], [size, size, depth]);
let holes = [];
let ds = [4.0, 6.0, 8.0, 10.0, 6.0];
for i in 0..5 { for j in 0..5 { let d = ds[(i + j) % 5]; holes.push(cylinder([10.0 + i.to_float() * (size - 20.0) / 4.0, 10.0 + j.to_float() * (size - 20.0) / 4.0, depth - 100.0], "Z", d / 2.0, 101.0)); } }
b - compound(holes)
