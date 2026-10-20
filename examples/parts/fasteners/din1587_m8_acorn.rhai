// DIN 1587 M8 domed cap (acorn) nut: 13 mm AF, 15 mm overall height, 6.5 mm thread depth
let across_flats = 13.0; // [9.4, 16.7] Width across flats (mm)
let hex_h = 6.5; // [3.0, 8.4] Hex height (mm)
let height = 15.0; // [12.5, 35.0] Overall height (mm)
let bore = 6.8; // [3.0, 20.0] Tap drill diameter (mm)
let rc = across_flats / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let hex = polygon(pts).to_face().extrude(hex_h).chamfer(0.5, "<Z");
let dome_r = across_flats * 0.45;
let dome = cylinder([0, 0, hex_h - 0.01], "Z", dome_r, height - hex_h - dome_r + 0.01)
    + sphere([0, 0, height - dome_r], dome_r);
(hex + dome) - cylinder([0, 0, -1], "Z", bore / 2.0, hex_h + 1.0) - cone(bore / 2.0, 0.1, bore * 0.3).translate([0, 0, hex_h - 0.01])
