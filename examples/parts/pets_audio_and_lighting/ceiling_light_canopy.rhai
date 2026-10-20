// Ceiling light canopy: 120 mm dome 40 mm tall with 1.5 mm wall, 10 mm cable grommet hole on top, two screw slots in the rim
let d = 120.0; // [80.0, 160.0] Canopy diameter (mm)
let h = 40.0; // [25.0, 60.0] Height (mm)
let R = (d * d / 4.0 + h * h) / (2.0 * h);
let shell = (sphere([0, 0, h - R], R) - sphere([0, 0, h - R], R - 1.5)) & box_centered(d + 10.0, d + 10.0, h).translate([0, 0, h / 2.0]);
let rim = cylinder(d / 2.0, 3.0) - cylinder([0, 0, -1], "Z", d / 2.0 - 8.0, 5.0);
let c = shell + rim - cylinder([0, 0, h - 5.0], "Z", 5.0, 10.0);
for s in [-1.0, 1.0] { c -= box_centered(8.0, 4.0, 10.0).translate([s * (d / 2.0 - 4.0), 0, 0]); }
c
