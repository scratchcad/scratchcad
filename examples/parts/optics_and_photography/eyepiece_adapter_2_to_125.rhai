// 2 in to 1.25 in eyepiece adapter: 50.8 mm barrel 30 mm long with an M48 x 0.75 filter thread inside (shown as a 47.6 mm bore) and a safety undercut, 58 mm top flange 10 mm tall with a 31.85 mm bore and one M5 thumbscrew
let barrel_od = 50.8; // [50.7, 50.8] Barrel diameter (mm)
let barrel_length = 30.0; // [15.0, 45.0] Barrel length (mm)
let flange_od = 58.0; // [54.0, 66.0] Flange diameter (mm)
let flange_height = 10.0; // [8.0, 20.0] Flange height (mm)
let bore = 31.85; // [31.8, 32.0] Eyepiece bore (mm)
let rb = barrel_od / 2.0;
let barrel = cylinder(rb, barrel_length + 0.1).chamfer(0.5, "%CIRCLE and <Z");
barrel -= torus(rb + 0.3, 1.0).translate([0, 0, barrel_length * 0.4]);
let flange = cylinder([0, 0, barrel_length], "Z", flange_od / 2.0, flange_height).chamfer(0.8, "%CIRCLE");
let body = barrel + flange;
let zs = barrel_length + flange_height / 2.0;
body -= cylinder([0, 0, -1.0], "Z", 23.8, 8.0);
body -= cylinder([0, 0, 6.5], "Z", bore / 2.0 + 3.0, barrel_length - 6.5 + 1.0);
body -= cylinder([0, 0, barrel_length - 1.0], "Z", bore / 2.0, flange_height + 2.0);
body -= cylinder([flange_od / 2.0 - 6.0, 0, zs], "X", 2.1, 10.0);
let screw = cylinder([bore / 2.0 + 0.3, 0, zs], "X", 2.0, flange_od / 2.0 + 3.0 - bore / 2.0 - 0.3) + cylinder([flange_od / 2.0 + 3.0, 0, zs], "X", 5.0, 5.0).chamfer(0.5, "%CIRCLE and >X");
compound([body, screw])
