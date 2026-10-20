// Brass pipe union, 1/2 in: male end with 21.3 mm tail, 30 mm hex union nut, female end, assembled 55 mm long
let tail_od = 21.3; // [13.0, 48.0] Pipe OD (mm)
let nut_hex = 32.0; // [22.0, 70.0] Union nut size (mm)
let length = 55.0; // [50.7, 100.0] Overall length (mm)
let hex = |af, h| { let rc = af / sqrt(3.0); let pts = []; for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); } polygon(pts).to_face().extrude(h) };
let tail_a = hex.call(nut_hex * 0.8, 10.0) + cylinder([0, 0, -12.0], "Z", tail_od / 2.0 + 2.0, 12.01) + cylinder([0, 0, 9.99], "Z", nut_hex * 0.38, 8.0);
let nut = hex.call(nut_hex, 14.0).translate([0, 0, 12.0]) - cylinder([0, 0, 10.0], "Z", nut_hex * 0.38 + 0.3, 20.0);
let tail_b = cylinder([0, 0, 22.0], "Z", nut_hex * 0.36, 6.0) + hex.call(nut_hex * 0.8, 10.0).translate([0, 0, 27.99]) + cylinder([0, 0, 37.98], "Z", tail_od / 2.0 + 2.0, length - 38.0 - 12.0);
let bore = cylinder([0, 0, -20], "Z", tail_od / 2.0 - 2.5, length + 40.0);
[tail_a - bore, nut, tail_b - bore]
