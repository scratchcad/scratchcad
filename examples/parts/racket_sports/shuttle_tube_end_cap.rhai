// Badminton shuttlecock tube end cap: 76 mm push-on cap for a 72 mm OD tube, 20 mm skirt with 4 crush ribs, 2 mm top with 6 x 4 mm vent holes
let tube_od = 72.0; // [68.0, 80.0] Tube outside diameter (mm)
let skirt = 20.0; // [12.0, 30.0] Skirt depth (mm)
const wall = 2.0;
let cap = cylinder([0, 0, 0], "Z", tube_od / 2.0 + wall, skirt + wall) - cylinder([0, 0, -1.0], "Z", tube_od / 2.0 + 0.3, skirt + 1.0);
let ribs = [];
for i in 0..4 { ribs.push(box_centered(1.0, 4.0, skirt - 4.0).translate([tube_od / 2.0 + 0.0, 0, (skirt - 4.0) / 2.0 + 2.0]).rotate_z(i.to_float() * 90.0)); }
let vents = [];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; vents.push(cylinder([tube_od * 0.25 * cos(a), tube_od * 0.25 * sin(a), skirt - 1.0], "Z", 2.0, wall + 2.0)); }
cap + fuse_all(ribs) - fuse_all(vents)
