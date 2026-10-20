// Pond liner pipe flange: 40 mm pipe through-liner seal, two-part clamp ring half 100 mm OD 6 mm thick with a 41 mm bore, 8 M5 holes on an 80 mm PCD and a 2 mm sealing bead
let pipe = 40.0; // [25.0, 63.0] Pipe OD (mm)
let od = 100.0; // [80.0, 140.0] Flange OD (mm)
const t = 6.0;
let f = cylinder([0, 0, 0], "Z", od / 2.0, t) - cylinder([0, 0, -1.0], "Z", pipe / 2.0 + 0.5, t + 2.0);
let bead = cylinder([0, 0, t - 0.01], "Z", pipe / 2.0 + 6.0, 2.0) - cylinder([0, 0, t - 1.0], "Z", pipe / 2.0 + 4.0, 4.0);
let holes = [];
let pcd = (od + pipe) / 2.0 - 5.0;
for i in 0..8 { let a = i.to_float() * PI() / 4.0; holes.push(cylinder([pcd / 2.0 * cos(a), pcd / 2.0 * sin(a), -1.0], "Z", 2.75, t + 2.0)); }
f + bead - fuse_all(holes)
