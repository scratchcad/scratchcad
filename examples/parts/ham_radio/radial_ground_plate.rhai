// Vertical antenna radial plate: 150 mm round plate 4 mm, 32 mm mast hole, 16 radial bolt holes 6.5 mm on a 130 mm PCD
let diameter = 150.0; // [100.0, 250.0] Plate diameter (mm)
let t = 4.0; // [3.0, 6.0] Thickness (mm)
let mast = 32.0; // [20.0, 50.0] Mast hole (mm)
let radials = 16; // [4, 32] Number of radials
let plate = cylinder(diameter / 2.0, t);
let holes = [cylinder([0, 0, -1], "Z", mast / 2.0, t + 2.0)];
for k in 0..radials { let a = (k.to_float() * 360.0 / radials.to_float()) * PI() / 180.0; holes.push(cylinder([(diameter / 2.0 - 10.0) * a.cos(), (diameter / 2.0 - 10.0) * a.sin(), -1], "Z", 3.25, t + 2.0)); }
plate - compound(holes)
