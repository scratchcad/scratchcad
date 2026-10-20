// Parachute shroud line ring / spill-hole reinforcement: 30 mm OD 18 mm ID 1.5 mm with 8 line holes 1.5 mm
let od = 30.0; // [30.0, 50.0] Outside diameter (mm)
let id = 18.0; // [10.0, 24.0] Inside diameter (mm)
let t = 1.5; // [1.0, 3.0] Thickness (mm)
let lines = 8; // [6, 16] Number of shroud lines
let ring = cylinder(od / 2.0, t) - cylinder([0, 0, -1], "Z", id / 2.0, t + 2.0);
let holes = [];
for k in 0..lines { let a = (k.to_float() * 360.0 / lines.to_float()) * PI() / 180.0; holes.push(cylinder([(od + id) / 4.0 * a.cos(), (od + id) / 4.0 * a.sin(), -1], "Z", 0.75, t + 2.0)); }
ring - compound(holes)
