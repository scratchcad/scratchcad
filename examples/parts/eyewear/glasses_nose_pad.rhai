// Push-in glasses nose pad: 15 x 9 mm oval-ish pad 2.5 mm thick (straight-segment octagon), with a 2.5 x 1.2 mm push-in stem box 3 mm tall on the back
let length = 15.0; // [11.0, 18.0] Pad length (mm)
let width = 9.0; // [7.0, 11.0] Pad width (mm)
const t = 2.5;
let pts = [];
for i in 0..8 { let a = (22.5 + 45.0 * i.to_float()) * PI() / 180.0; pts.push([length / 2.0 * cos(a) / cos(PI() / 8.0), width / 2.0 * sin(a) / cos(PI() / 8.0), 0]); }
let pad = face(polygon(pts)).extrude([0, 0, t]);
let stem = box_centered(2.5, 1.2, 3.0).translate([0, 0, t + 1.5 - 0.01]) + box_centered(3.2, 1.2, 0.8).translate([0, 0, t + 2.6]);
pad + stem
