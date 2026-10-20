// RCA plug shell: 3.2 mm centre pin, split 8.3 mm outer sleeve 8 mm long, 9.5 mm body 22 mm long with a 5 mm cable entry and strain relief
let body_d = 9.5; // [8.0, 12.0] Body diameter (mm)
let body = cylinder(body_d / 2.0, 22.0).chamfer(0.6, "%CIRCLE") - cylinder([0, 0, 15.0], "Z", 2.5, 10.0);
let sleeve = cylinder([0, 0, -8.0], "Z", 4.15, 8.1) - cylinder([0, 0, -9.0], "Z", 3.65, 9.0);
for k in 0..4 { sleeve -= box_centered(0.6, 10.0, 5.0).translate([0, 0, -6.0]).rotate_z(k.to_float() * 45.0); }
let pin = cylinder([0, 0, -10.0], "Z", 1.6, 10.1) + cone(0.6, 1.6, 1.5).translate([0, 0, -11.5]);
let relief = cylinder([0, 0, 22.0], "Z", 3.0, 10.0) - cylinder([0, 0, 21.0], "Z", 2.5, 12.0);
fuse_all([body, sleeve, pin, relief])
