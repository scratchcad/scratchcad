// Bump-sensor lever for a robot: 2.5 mm thick curved arm with 70 mm reach and 40 mm radius, 4 mm pivot boss with a 2 mm pin hole, cam nose that presses a KW11 microswitch lever, M2 return-spring hook hole
let reach = 70.0; // [40.0, 120.0] Arm reach (mm)
let curve_r = 40.0; // [25.0, 80.0] Arm curve radius (mm)
let t = 2.5; // [1.5, 4.0] Arm thickness (mm)
let width = 6.0; // [4.0, 10.0] Arm width in plan (mm)
let cr = max(curve_r, reach * 0.55);
let sag = cr - (cr * cr - reach * reach / 4.0).sqrt();
let arc_outer = sketch("XY").move_to(0, 0).arc_to(reach / 2.0, sag, reach, 0).line_to(reach, -width).arc_to(reach / 2.0, sag - width, 0, -width).close();
let arm = arc_outer.to_face().extrude([0, 0, t]);
let boss = cylinder([0, -width / 2.0, 0], "Z", 4.0, t + 1.5);
let nose = polygon([[-2.0, -width / 2.0 - 3.0], [-9.0, -width / 2.0 - 3.0], [-2.0, -width / 2.0 + 3.5]]).to_face().extrude([0, 0, t]);
let pad = cylinder([reach, -width / 2.0, 0], "Z", width / 2.0 + 1.0, t);
let b = fuse_all([arm, boss, nose, pad]);
b -= cylinder([0, -width / 2.0, -1], "Z", 1.0, t + 4.0);
b - cylinder([12.0, sag * 0.4 - width / 2.0, -1], "Z", 0.9, t + 2.0)
