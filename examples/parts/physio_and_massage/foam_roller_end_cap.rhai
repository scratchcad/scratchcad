// Foam roller end cap: 150 mm cap 10 mm thick with a 3 mm chamfer, pressing into a 110 mm core tube (102 mm ID) with a 25 mm spigot and 4 crush ribs, plus a 20 mm grip hole
let roller = 150.0; // [100.0, 180.0] Roller diameter (mm)
let core_id = 102.0; // [60.0, 120.0] Core tube ID (mm)
const t = 10.0;
let cap = cylinder([0, 0, 0], "Z", roller / 2.0, t);
let cap = cap.chamfer(3.0, cap.edges(">Z"));
let spig = cylinder([0, 0, -25.0], "Z", core_id / 2.0 - 0.4, 25.01) - cylinder([0, 0, -26.0], "Z", core_id / 2.0 - 4.0, 25.0);
let ribs = [];
for i in 0..4 { ribs.push(box_centered(1.2, 6.0, 20.0).translate([core_id / 2.0 - 0.3, 0, -12.0]).rotate_z(i.to_float() * 90.0)); }
cap + spig + fuse_all(ribs) - cylinder([0, 0, -30.0], "Z", 10.0, 50.0)
