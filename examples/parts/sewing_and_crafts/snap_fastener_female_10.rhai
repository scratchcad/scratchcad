// Sew-on press stud, female half, 10 mm: 2.6 mm tall socket ring for a 3 mm ball, 4 sewing holes
let diameter = 10.0; // [6.0, 18.0] Disc diameter (mm)
let socket = 3.0; // [2.0, 5.0] Socket bore (mm)
let plate = cylinder(diameter / 2.0, 1.0) + cylinder([0, 0, 0.99], "Z", socket / 2.0 + 1.0, 1.6);
let cavity = cylinder([0, 0, -1], "Z", socket / 2.0 - 0.2, 4.0) + sphere([0, 0, 1.6], socket / 2.0);
let holes = [];
for k in 0..4 { let a = (k.to_float() * 90.0 + 45.0) * PI() / 180.0; holes.push(cylinder([(diameter / 2.0 - 1.4) * a.cos(), (diameter / 2.0 - 1.4) * a.sin(), -1], "Z", 0.6, 3.0)); }
plate - cavity - compound(holes)
