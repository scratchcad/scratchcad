// One-piece rigid clamp shaft coupling, 8 mm to 8 mm: 20 mm OD, 25 mm long, a 0.8 mm slit at each end with an M3 clamp screw, 0.5 mm chamfers
let bore = 8.0; // [3.0, 20.0] Bore diameter (mm)
let outer_diameter = 20.0; // [10.0, 45.0] Outer diameter (mm)
let length = 25.0; // [12.0, 60.0] Length (mm)
let slit = 0.8; // [0.4, 1.5] Clamp slit width (mm)
const screw_clear = 3.4;
const screw_tap = 2.5;
const counterbore = 5.5;
let ri = bore / 2.0;
let ro = max(outer_diameter / 2.0, ri + 5.0);
let cpl = cylinder(ro, length).chamfer(0.5, "%CIRCLE") - cylinder([0, 0, -1], "Z", ri, length + 2.0);
let xs = (ri + ro) / 2.0 + 0.3;
let cuts = [];
for e in [0, 1] {
    let z0 = if e == 0 { -1.0 } else { length * 0.55 };
    let zc = if e == 0 { length * 0.22 } else { length * 0.78 };
    let slot = box_from_corners([0, -slit / 2.0, z0], [ro + 1.0, slit / 2.0, z0 + length * 0.45 + 1.0]);
    let holes = fuse_all([cylinder([xs, 0, zc], "Y", screw_clear / 2.0, ro + 1.0), cylinder([xs, ri * 0.6, zc], "Y", counterbore / 2.0, ro), cylinder([xs, 0.1, zc], "-Y", screw_tap / 2.0, ro + 1.0)]);
    cuts.push(slot);
    cuts.push(holes);
}
cpl - cuts[0] - cuts[1] - cuts[2] - cuts[3]
