// Aquarium airline check valve body: 4/6 mm tubing barbs, 26 mm long, 10 mm body
let tube_id = 4.0; // [3.0, 6.0] Tubing inside diameter (mm)
let body_d = 10.0; // [8.0, 14.0] Body diameter (mm)
let body_l = 10.0; // [6.0, 16.0] Body length (mm)
let barb_l = 8.0; // [5.0, 12.0] Barb length (mm)
let barb = cone(tube_id / 2.0 + 0.4, tube_id / 2.0 - 0.2, barb_l);
let body = cylinder(body_d / 2.0, body_l) + barb.translate([0, 0, body_l - 0.01]) + barb.rotate_x(180.0).translate([0, 0, 0.01]);
let b = body.fillet(1.0, body.edges("%CIRCLE").filter(|e| e.radius() > body_d / 2.0 - 0.01));
b - cylinder([0, 0, -barb_l - 1.0], "Z", 1.0, body_l + 2.0 * barb_l + 2.0) - cylinder([0, 0, 2.0], "Z", body_d / 2.0 - 1.5, body_l - 4.0)
