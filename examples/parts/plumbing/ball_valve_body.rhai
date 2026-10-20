// 1/2 in two-piece ball valve: 46 mm hex-ended body, 15 mm full bore, 25 mm ball, stem and 90 mm lever handle
let length = 46.0; // [35.0, 100.0] Body length (mm)
let body_d = 32.0; // [24.0, 70.0] Body diameter (mm)
let bore = 15.0; // [8.0, 50.0] Bore (mm)
let handle_l = 90.0; // [50.0, 180.0] Handle length (mm)
let rc = body_d * 0.9 / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let ends = polygon(pts).to_face().extrude(10.0).rotate_y(90).translate([-length / 2.0, 0, 0]);
let body = fuse_all([cylinder([-length / 2.0 + 9.0, 0, 0], "X", body_d / 2.0, length - 18.0), ends, ends.translate([length - 10.0, 0, 0]), cylinder(body_d * 0.25, body_d * 0.85)]);
body = body - cylinder([-length, 0, 0], "X", bore / 2.0, length * 2.0);
let stem = cylinder([0, 0, body_d * 0.85 - 1.0], "Z", 4.0, 8.0);
let handle = (box_centered(handle_l, 14.0, 3.0).translate([handle_l / 2.0 - 8.0, 0, body_d * 0.85 + 6.0]) + cylinder([0, 0, body_d * 0.85 + 4.5], "Z", 9.0, 3.0)).fillet(1.0, "|Z");
[body, stem, handle]
