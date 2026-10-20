// 3/4 in Y-strainer: 70 mm body, 20 mm bore, screen leg at 45 degrees with a 30 mm hex plug
let length = 70.0; // [50.0, 150.0] Length (mm)
let body_d = 30.0; // [20.0, 70.0] Body diameter (mm)
let bore = 20.0; // [10.0, 50.0] Bore (mm)
let leg_l = 45.0; // [30.0, 100.0] Screen leg length (mm)
let body = cylinder([-length / 2.0, 0, 0], "X", body_d / 2.0, length) + sphere(body_d * 0.62);
let leg = cylinder([0, 0, 0], [0.7071, 0, -0.7071], body_d * 0.45, leg_l);
let rc = body_d * 0.5 / 0.866;
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let plug = polygon(pts).to_face().extrude(8.0).rotate_y(135).translate([leg_l * 0.7071, 0, -leg_l * 0.7071]);
fuse_all([body, leg, plug]) - cylinder([-length, 0, 0], "X", bore / 2.0, length * 2.0) - cylinder([0, 0, 0], [0.7071, 0, -0.7071], body_d * 0.3, leg_l - 3.0)
