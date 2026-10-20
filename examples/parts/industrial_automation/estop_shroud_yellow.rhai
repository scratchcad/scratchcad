// Emergency stop protective shroud: 75 mm yellow-style surround, 50 mm tall wings, 22.3 mm hole, 40 mm mushroom clearance
let od = 75.0; // [60.0, 100.0] Base diameter (mm)
let height = 50.0; // [35.0, 70.0] Wing height (mm)
let clear = 46.0; // [40.0, 60.0] Inner clearance (mm)
let hole = 22.3; // [16.2, 30.5] Mounting hole (mm)
let base = cylinder(od / 2.0, 3.0) - cylinder([0, 0, -1], "Z", hole / 2.0, 5.0);
let wings = cylinder([0, 0, 2.99], "Z", od / 2.0, height - 3.0) - cylinder([0, 0, 2.0], "Z", clear / 2.0, height) - box_from_corners([-od, -od, 15.0], [od, -10.0, height + 1.0]) - box_from_corners([-od, 10.0, 15.0], [od, od, height + 1.0]);
base + wings
