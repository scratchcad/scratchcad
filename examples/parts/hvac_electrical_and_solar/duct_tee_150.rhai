// Round galvanized HVAC duct tee, 6 in (150 mm) main run 250 mm long with a 6 in branch 100 mm tall, 0.8 mm wall, reinforcing saddle collar at the branch
let main_d = 150.0; // [80.0, 300.0] Main duct diameter (mm)
let branch_d = 150.0; // [60.0, 300.0] Branch diameter (mm)
let run = 250.0; // [150.0, 500.0] Main run length (mm)
let branch_h = 100.0; // [40.0, 200.0] Branch height above the main axis (mm)
const t = 0.8;
let rm = main_d / 2.0;
let rb = min(branch_d, main_d) / 2.0;
let bh = max(branch_h, rm + 20.0);
let outer = cylinder([-run / 2.0, 0, 0], "X", rm, run) + cylinder([0, 0, 0], "Z", rb, bh);
let inner = cylinder([-run / 2.0 - 1.0, 0, 0], "X", rm - t, run + 2.0) + cylinder([0, 0, 0], "Z", rb - t, bh + 1.0);
let saddle = (cylinder([0, 0, 0], "Z", rb + 6.0, rm + 12.0) & cylinder([-rb - 10.0, 0, 0], "X", rm + t, 2.0 * rb + 20.0));
(outer + saddle) - inner
