// Telescope 1.25 in visual back / eyepiece holder: 31.85 mm bore, 38 mm OD tube 30 mm long, 50 mm base flange with 2"-24 SCT internal thread (shown as a 48.4 mm bore), brass compression-ring groove, two M6 thumbscrews 120 deg apart
let bore = 31.85; // [31.8, 32.0] Eyepiece bore (mm)
let tube_od = 38.0; // [36.0, 44.0] Tube outside diameter (mm)
let tube_length = 30.0; // [20.0, 50.0] Tube length above the flange (mm)
let flange_od = 54.0; // [52.0, 60.0] Flange outside diameter (mm)
let flange_height = 9.0; // [6.0, 14.0] Flange height (mm)
let rt = tube_od / 2.0;
let body = cylinder(flange_od / 2.0, flange_height).chamfer(0.6, "%CIRCLE");
body = body + cylinder([0, 0, flange_height - 0.1], "Z", rt, tube_length + 0.1).chamfer(0.6, "%CIRCLE and >Z");
// thumbscrew bosses
let zs = flange_height + tube_length - 9.0;
let bosses = [];
for a in [0.0, 120.0] {
    bosses.push(cylinder([rt - 2.0, 0, zs], "X", 5.0, 6.0).rotate_z(a));
}
body = fuse_all([body] + bosses);
body -= cylinder([0, 0, -1.0], "Z", bore / 2.0, flange_height + tube_length + 2.0);
body -= cylinder([0, 0, -1.0], "Z", 24.2, 7.0);
body -= cylinder([0, 0, zs - 3.0], "Z", bore / 2.0 + 0.8, 6.0);
let screws = [];
for a in [0.0, 120.0] {
    body -= cylinder([rt - 3.0, 0, zs], "X", 2.5, 8.0).rotate_z(a);
    // thumbscrew: knurled 12 mm head and M6 shank, its tip at the compression ring
    let s = cylinder([bore / 2.0 + 0.9, 0, zs], "X", 2.4, rt + 4.0 - bore / 2.0 - 0.9) + cylinder([rt + 4.0, 0, zs], "X", 6.0, 6.0).chamfer(0.6, "%CIRCLE and >X");
    screws.push(s.rotate_z(a));
}
compound([body] + screws)
