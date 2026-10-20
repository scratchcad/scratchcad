// Wardrobe rail end support for 25 mm round rail: 45 mm round plate 4 mm, closed cup 27 mm deep 12 mm, 3 screw holes
let rail = 25.0; // [16.0, 32.0] Rail diameter (mm)
let plate = 45.0; // [35.0, 60.0] Plate diameter (mm)
let p = cylinder(plate / 2.0, 4.0);
let cup = cylinder([0, 0, 3.99], "Z", rail / 2.0 + 2.5, 12.0) - cylinder([0, 0, 5.5], "Z", rail / 2.0 + 0.3, 12.0);
let holes = [];
for k in 0..3 { let a = (k.to_float() * 120.0 + 90.0) * PI() / 180.0; holes.push(cylinder([(plate / 2.0 - 4.5) * a.cos(), (plate / 2.0 - 4.5) * a.sin(), -1], "Z", 1.9, 6.0)); }
p + cup - compound(holes)
