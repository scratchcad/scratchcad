// Compression olive puller for 15 mm fittings: 34 mm body 32 mm tall, 24 mm cup that takes the 15 mm compression nut, 18 mm pipe slot, M12 forcing screw boss 20 mm with 10.2 mm tap bore, two 25 mm wings
let body_d = 34.0; // [28.0, 45.0] Body diameter (mm)
let body_h = 32.0; // [24.0, 45.0] Body height (mm)
let cup = 24.0; // [18.0, 34.0] Nut cup diameter (mm)
let pipe_slot = 18.0; // [12.0, 26.0] Pipe slot width (mm)
let wing = 25.0; // [15.0, 40.0] Wing length (mm)
let r = body_d / 2.0;
let rc = min(cup / 2.0, r - 3.0);
let body = cylinder(r, body_h) + cylinder([0, 0, body_h - 0.5], "Z", 10.0, 10.5);
let wings = box_centered(body_d + 2.0 * wing, 8.0, 10.0).translate([0, 0, body_h - 5.0]);
let wings = wings.fillet(3.5, wings.edges("|Y"));
let cuts = cylinder([0, 0, -1], "Z", rc, body_h - 6.0 + 1.0) + box_from_corners([-min(pipe_slot, rc * 2.0 - 2.0) / 2.0, 0, -1], [min(pipe_slot, rc * 2.0 - 2.0) / 2.0, r + 1.0, body_h * 0.6]);
body + wings - cuts - cylinder([0, 0, body_h - 10.0], "Z", 5.1, 30.0)
