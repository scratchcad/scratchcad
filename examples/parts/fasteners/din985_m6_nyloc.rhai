// DIN 985 M6 nylon insert lock nut: 10 mm AF, 6 mm total height, round collar holding the insert
let across_flats = 10.0; // [5.5, 24.0] Width across flats (mm)
let height = 6.0; // [3.0, 15.0] Overall height (mm)
let hex_h = 4.0; // [2.0, 10.0] Hex height (mm)
let bore = 5.0; // [2.5, 14.0] Bore (mm)
let rc = across_flats / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let hex = polygon(pts).to_face().extrude(hex_h).chamfer(0.4, "<Z");
let collar = cylinder([0, 0, hex_h - 0.01], "Z", across_flats * 0.47, height - hex_h + 0.01).fillet(0.6, ">Z");
(hex + collar) - cylinder([0, 0, -1], "Z", bore / 2.0, height + 2.0)
