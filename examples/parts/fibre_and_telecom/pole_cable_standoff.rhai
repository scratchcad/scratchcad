// Telecom pole cable standoff bracket: 120 mm arm 30 x 6 mm off a 60 x 60 mm band plate with two 10.5 mm bolt holes, ending in a 20 mm cable saddle with a 6 mm tie slot
let arm = 120.0; // [60.0, 200.0] Standoff length (mm)
let saddle = 20.0; // [10.0, 30.0] Cable saddle diameter (mm)
const t = 6.0;
let plate = box_from_corners([0, -30.0, 0], [t, 30.0, 60.0]);
let a = box_from_corners([t - 0.01, -15.0, 25.0], [t + arm, 15.0, 25.0 + t]);
let s = cylinder([t + arm, -15.0, 25.0 + t + saddle / 2.0], "Y", saddle / 2.0 + 4.0, 30.0) - cylinder([t + arm, -16.0, 25.0 + t + saddle / 2.0], "Y", saddle / 2.0, 32.0) - box_from_corners([t + arm - saddle, -16.0, 25.0 + t + saddle / 2.0], [t + arm + saddle, 16.0, 25.0 + 2.0 * saddle + t]);
plate + a + s - cylinder([-1.0, 0, 12.0], "X", 5.25, t + 2.0) - cylinder([-1.0, 0, 48.0], "X", 5.25, t + 2.0) - box_from_corners([t + arm - 3.0, -16.0, 25.0 + t - 1.0], [t + arm + 3.0, 16.0, 25.0 + t + 2.0])
