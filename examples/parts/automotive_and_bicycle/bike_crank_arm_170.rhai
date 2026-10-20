// 170 mm crank arm: 24 mm spindle bore in a 38 mm boss, 9/16 in pedal eye in a 24 mm boss, 16 mm thick, rounded top edges
let length = 170.0; // [150.0, 180.0] Crank length (mm)
let thick = 16.0; // [12.0, 20.0] Thickness (mm)
let r1 = 19.0; // [15.0, 24.0] Spindle boss radius (mm)
let r2 = 12.0; // [10.0, 15.0] Pedal boss radius (mm)
let c = (r1 - r2) / length;
let s = sqrt(1.0 - c * c);
let profile = sketch().move_to(r1 * c, -r1 * s).line_to(length + r2 * c, -r2 * s).arc_to(length + r2, 0, length + r2 * c, r2 * s).line_to(r1 * c, r1 * s).arc_to(-r1, 0, r1 * c, -r1 * s).close();
let arm = profile.to_face().extrude(thick).fillet(2.0, ">Z");
arm - cylinder([0, 0, -1], "Z", 12.0, thick + 2.0) - cylinder([length, 0, -1], "Z", 7.15, thick + 2.0)
