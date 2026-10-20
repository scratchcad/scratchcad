// Hand crank: 80 mm throw, 8 mm square drive 15 mm deep, 22 mm print-in-place spinning grip 50 mm long (two solids)
let crank_r = 80.0; // [40.0, 150.0] Crank radius (mm)
let drive = 8.0; // [5.0, 14.0] Square drive (mm)
let grip_l = 50.0; // [30.0, 80.0] Grip length (mm)
let t = 8.0; // [5.0, 12.0] Arm thickness (mm)
let arm = box_from_corners([0, -8.0, 0], [crank_r, 8.0, t]) + cylinder(13.0, t) + cylinder([crank_r, 0, 0], "Z", 8.0, t);
let boss = cylinder([0, 0, -15.0], "Z", 10.0, 15.01);
let spindle = cylinder([crank_r, 0, t - 0.01], "Z", 5.0, grip_l + 4.01) + cylinder([crank_r, 0, t + grip_l + 2.0], "Z", 8.0, 2.0);
let sleeve = cylinder([crank_r, 0, t + 1.5], "Z", 11.0, grip_l) - cylinder([crank_r, 0, t + 1.0], "Z", 5.5, grip_l + 1.0);
arm + boss + spindle + sleeve - box_centered(drive, drive, 30.0).translate([0, 0, -15.0])
