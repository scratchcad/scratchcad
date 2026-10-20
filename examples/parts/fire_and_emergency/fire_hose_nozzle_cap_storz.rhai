// Storz C (52 mm) blank cap body: 81 mm OD 30 mm, 2 hook lugs, 66 mm seal seat, 8 mm chain eye
let od = 81.0; // [64.0, 105.0] Coupling OD (mm)
let height = 30.0; // [20.0, 40.0] Height (mm)
let seat = 66.0; // [50.0, 89.0] Seal seat diameter (mm)
let body = cylinder(od / 2.0, height) - cylinder([0, 0, -1], "Z", seat / 2.0, 12.0);
let lugs = [];
for k in 0..2 { lugs.push((box_from_corners([-12.0, od / 2.0 - 3.0, -8.0], [12.0, od / 2.0 + 4.0, 0.01]) - box_from_corners([-6.0, od / 2.0 - 4.0, -6.0], [13.0, od / 2.0 + 1.5, -3.0])).rotate_z(k.to_float() * 180.0)); }
let eye = cylinder([0, -4.0, height + 6.0], "Y", 8.0, 8.0) - cylinder([0, -5.0, height + 6.0], "Y", 4.0, 10.0);
let knobs = [];
for k in 0..2 { knobs.push(box_centered(10.0, 20.0, 10.0).translate([od / 2.0, 0, height / 2.0]).rotate_z(k.to_float() * 180.0 + 90.0)); }
body + fuse_all(lugs) + eye + fuse_all(knobs)
