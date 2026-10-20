// Microphone thread adapter: 5/8-27 UNS female (15.9 mm) to 3/8-16 UNC male (9.5 mm), 20 mm knurled body, slotted male end
let body_d = 20.0; // [16.0, 26.0] Body diameter (mm)
let body = cylinder(body_d / 2.0, 14.0).chamfer(0.8, "%CIRCLE") - cylinder([0, 0, 2.0], "Z", 7.6, 13.0);
for k in 0..30 { body -= cylinder([body_d / 2.0 + 0.2, 0, 1.0], "Z", 0.45, 12.0).rotate("Z", k.to_float() * 12.0); }
let male = cylinder([0, 0, -10.0], "Z", 4.6, 10.1).chamfer(0.6, "<Z");
for k in 0..6 { male -= torus(4.65, 0.45).translate([0, 0, -9.0 + k.to_float() * 1.6]); }
(body + male) - box_centered(1.5, 12.0, 3.0).translate([0, 0, -10.0])
