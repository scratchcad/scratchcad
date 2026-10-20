// Router template guide bushing, 30 mm: 50 mm flange 3 mm thick, 30 mm collar 8 mm long, 26 mm bore, 2 countersunk M4 holes on a 40 mm circle
let collar_d = 30.0; // [17.0, 40.0] Collar diameter (mm)
let collar_l = 8.0; // [4.0, 14.0] Collar length (mm)
let wall = 2.0; // [1.2, 4.0] Collar wall (mm)
let flange_d = 50.0; // [40.0, 70.0] Flange diameter (mm)
let flange_t = 3.0; // [2.0, 5.0] Flange thickness (mm)
let rc = collar_d / 2.0;
let rf = max(flange_d / 2.0, rc + 10.0);
let flange = cylinder(rf, flange_t);
let collar = cylinder([0, 0, -collar_l], "Z", rc, collar_l + 0.5);
let c = collar.chamfer(0.5, collar.edges("<Z"));
let hr = (rc + rf) / 2.0;
let holes = [];
for s in [-1.0, 1.0] { holes.push(cylinder([s * hr, 0, -1], "Z", 2.2, flange_t + 2.0) + cone(2.2, 4.2, 2.0).translate([s * hr, 0, flange_t - 1.99])); }
flange + c - cylinder([0, 0, -collar_l - 1.0], "Z", rc - wall, collar_l + flange_t + 2.0) - fuse_all(holes)
