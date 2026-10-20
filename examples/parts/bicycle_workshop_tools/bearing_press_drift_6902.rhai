// Hub bearing press drift for 6902 bearings (15 x 28 x 7 mm): 14.9 mm pilot 6 mm long, 27.6 mm shoulder 20 mm long that presses the outer race, 12.2 mm bore for the press rod (narrower for small bearings), 0.6 mm pilot chamfer and 1 mm shoulder chamfer
let bearing_id = 15.0; // [8.0, 20.0] Bearing bore (mm)
let bearing_od = 28.0; // [22.0, 42.0] Bearing outside diameter (mm)
let pilot_len = 6.0; // [4.0, 10.0] Pilot length (mm)
let body_len = 20.0; // [12.0, 40.0] Body length (mm)
let pilot_d = bearing_id - 0.1;
let body_d = bearing_od - 0.4;
let rod = min(12.2, pilot_d - 3.0);
let body = cylinder(body_d / 2.0, body_len);
let body = body.chamfer(1.0, body.edges("<Z"));
let pilot = cylinder([0, 0, body_len - 0.5], "Z", pilot_d / 2.0, pilot_len + 0.5);
let pilot = pilot.chamfer(0.6, pilot.edges(">Z"));
(body + pilot) - cylinder([0, 0, -1.0], "Z", rod / 2.0, body_len + pilot_len + 2.0)
