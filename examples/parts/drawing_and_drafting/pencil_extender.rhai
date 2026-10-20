// Pencil extender for 7 mm pencils: 90 mm, 9 mm body, split collet 20 mm with a 12 mm sliding ring groove
let pencil = 7.2; // [6.5, 8.5] Pencil diameter (mm)
let length = 90.0; // [60.0, 120.0] Length (mm)
let body_d = 9.5; // [8.5, 12.0] Body diameter (mm)
let collet = 20.0; // [12.0, 30.0] Collet length (mm)
let body = cylinder(body_d / 2.0, length) + sphere([0, 0, 0], body_d / 2.0);
let cut = cylinder([0, 0, length - collet - 5.0], "Z", pencil / 2.0, collet + 6.0);
let slots = box_centered(1.0, body_d + 2.0, collet).translate([0, 0, length - collet / 2.0 + 0.5]) + box_centered(body_d + 2.0, 1.0, collet).translate([0, 0, length - collet / 2.0 + 0.5]);
let taper = cylinder([0, 0, length - 8.0], "Z", body_d, 9.0) - cone(body_d / 2.0, body_d / 2.0 - 0.8, 8.0).translate([0, 0, length - 8.0]);
body - cut - slots - taper
