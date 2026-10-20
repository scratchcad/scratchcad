// 8 mm dowel center point: 7.9 mm body 8 mm long, 11 mm marking shoulder 1.5 mm, 2 mm point
let d = 8.0; // [6.0, 12.0] Dowel hole diameter (mm)
let body = cylinder([0, 0, -8.0], "Z", d / 2.0 - 0.05, 8.01);
let shoulder = cylinder(d / 2.0 + 1.5, 1.5);
let point = cone(1.0, 0.05, 2.0).translate([0, 0, 1.49]);
let rim = cylinder([0, 0, 1.49], "Z", d / 2.0 + 1.5, 0.5) - cylinder([0, 0, 1.0], "Z", d / 2.0 + 0.8, 2.0);
body + shoulder + point + rim
