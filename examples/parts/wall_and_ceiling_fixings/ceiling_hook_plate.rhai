// Ceiling hook plate: 60 mm round plate 4 mm thick with three 4.5 mm countersunk holes on a 44 mm PCD and a 6 mm round-bar J-hook dropping 40 mm with a 25 mm throat
let plate_d = 60.0; // [45.0, 80.0] Plate diameter (mm)
let drop = 40.0; // [25.0, 60.0] Hook drop (mm)
const t = 4.0;
const bar = 6.0;
let p = cylinder([0, 0, 0], "Z", plate_d / 2.0, t);
let stem = cylinder([0, 0, -drop], "Z", bar / 2.0, drop + 0.01);
let bend = (cylinder([12.5 + bar / 2.0 - bar / 2.0, -bar / 2.0, -drop], "Y", 12.5 + bar, bar) - cylinder([12.5, -bar, -drop], "Y", 12.5, 2.0 * bar) - box_from_corners([-30.0, -10.0, -drop], [40.0, 10.0, 0])).translate([0, 0, 0]);
let tip = cylinder([25.0 + bar / 2.0 + bar / 2.0 - bar / 2.0, 0, -drop], "Z", bar / 2.0, 10.0);
let holes = [];
for i in 0..3 { let a = (90.0 + 120.0 * i.to_float()) * PI() / 180.0; holes.push(cylinder([22.0 * cos(a), 22.0 * sin(a), -1.0], "Z", 2.25, t + 2.0)); holes.push(cone(2.25, 4.5, 2.25).translate([22.0 * cos(a), 22.0 * sin(a), t - 2.24])); }
p + stem + bend + tip - fuse_all(holes)
