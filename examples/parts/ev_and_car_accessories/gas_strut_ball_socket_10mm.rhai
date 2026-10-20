// Boot lid gas strut end fitting for a 10 mm ball stud: 18 mm body 24 mm long, 10.1 mm spherical socket entered from the side through an 8.4 mm neck, M8 tapping bore 6.8 mm x 12 mm, 1.2 mm retaining clip slot
let ball = 10.0; // [8.0, 13.0] Ball stud diameter (mm)
let body_d = 18.0; // [16.0, 24.0] Body diameter (mm)
let length = 24.0; // [20.0, 34.0] Body length (mm)
let tap = 6.8; // [5.0, 8.5] Thread tapping bore (mm)
let tap_depth = 12.0; // [8.0, 16.0] Thread depth (mm)

let zc = length - body_d / 2.0;
let body = cylinder(body_d / 2.0, length - body_d / 2.0) + sphere([0, 0, zc], body_d / 2.0);
body = body & box_from_corners([-body_d, -body_d, -1.0], [body_d, body_d, length]);
body = body - sphere([0, 0, zc], ball / 2.0 + 0.05);
body = body - cylinder([0, 0, zc], "X", ball * 0.42, body_d);
body = body - cylinder([0, 0, -1.0], "Z", tap / 2.0, min(tap_depth, zc - ball / 2.0 - 2.0) + 1.0);
body = body - box_from_corners([-body_d, -body_d, zc - 0.6], [-body_d / 2.0 + 1.5, body_d, zc + 0.6]);
body.chamfer(0.6, body.edges("<Z"))
