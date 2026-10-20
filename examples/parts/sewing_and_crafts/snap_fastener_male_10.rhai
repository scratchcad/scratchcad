// Sew-on press stud, male half, 10 mm: 1 mm disc, 3 mm stud with ball tip, 4 sewing holes
let diameter = 10.0; // [6.0, 18.0] Disc diameter (mm)
let stud_d = 3.0; // [2.0, 5.0] Stud diameter (mm)
let plate = cylinder(diameter / 2.0, 1.0);
let stud = cylinder([0, 0, 0.99], "Z", stud_d / 2.0 - 0.3, 1.2) + sphere([0, 0, 2.6], stud_d / 2.0);
let holes = [];
for k in 0..4 { let a = (k.to_float() * 90.0 + 45.0) * PI() / 180.0; holes.push(cylinder([(diameter / 2.0 - 1.4) * a.cos(), (diameter / 2.0 - 1.4) * a.sin(), -1], "Z", 0.6, 3.0)); }
plate + stud - compound(holes)
