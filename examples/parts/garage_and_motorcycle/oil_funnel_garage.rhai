// Garage oil funnel: 160 mm mouth, 75 mm tall cone into a 15 mm spout 70 mm long with a 25 degree tip, 1.5 mm wall, rolled 3 mm rim, hanging tab with a 6 mm hole
let mouth_d = 160.0; // [80.0, 250.0] Mouth diameter (mm)
let cone_height = 75.0; // [40.0, 150.0] Cone height (mm)
let spout_d = 15.0; // [8.0, 30.0] Spout outer diameter (mm)
let spout_length = 70.0; // [20.0, 150.0] Spout length (mm)
let wall = 1.5; // [1.0, 3.0] Wall thickness (mm)
let rs = spout_d / 2.0;
let rm = mouth_d / 2.0;
let zt = spout_length + cone_height;
// wall offset measured across the slope of the cone
let slope = (rm - rs) / cone_height;
let dw = wall * sqrt(1.0 + slope * slope);
let prof = [[rs - wall, 0.0], [rs, 0.0], [rs, spout_length], [rm, zt - 3.0], [rm + 3.0, zt - 3.0], [rm + 3.0, zt], [rm - dw, zt], [rs - wall, spout_length + wall * 0.4]];
let funnel = polygon("XZ", prof).to_face().revolve("Z", 360);
let tab = box_from_corners([rm + 2.0, -10.0, zt - 2.0], [rm + 22.0, 10.0, zt]).fillet(8.0, "|Z and >X");
funnel = funnel + tab - cylinder([rm + 14.0, 0, zt - 5.0], "Z", 3.0, 10.0);
// spout tip cut at 25 degrees
funnel - box_from_corners([-rs - 5.0, -rs - 5.0, -20.0], [rs + 5.0, rs + 5.0, 0]).rotate([0, 0, 0], "Y", 25.0)
