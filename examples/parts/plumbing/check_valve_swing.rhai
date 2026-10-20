// 1 in brass swing check valve body: 80 mm long, 45 mm body with a 50 mm bonnet cap, 25 mm bore, hex ends 38 mm
let length = 80.0; // [50.0, 160.0] Length (mm)
let body_d = 45.0; // [30.0, 100.0] Body diameter (mm)
let bore = 25.0; // [12.0, 60.0] Bore (mm)
let hex = 38.0; // [24.0, 80.0] End hex size (mm)
let rc = hex / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let ends = polygon(pts).to_face().extrude(14.0).rotate_y(90);
let body = fuse_all([sphere(body_d / 2.0), cylinder([-length / 2.0, 0, 0], "X", body_d * 0.35, length), ends.translate([-length / 2.0, 0, 0]), ends.translate([length / 2.0 - 14.0, 0, 0]), cylinder([0, 0, 0], "Z", body_d * 0.45, body_d * 0.6)]);
let bonnet = polygon(pts).scale(0.9).to_face().extrude(10.0).translate([0, 0, body_d * 0.6 - 0.01]);
(body + bonnet) - cylinder([-length, 0, 0], "X", bore / 2.0, length * 2.0) - sphere(body_d / 2.0 - 4.0)
