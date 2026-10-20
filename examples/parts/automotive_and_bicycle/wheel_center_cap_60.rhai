// Alloy wheel centre cap, 60 mm: 10 mm high 2 mm domed shell, four snap legs with barbs, 18 mm logo recess
let d = 60.0; // [50.0, 76.0] Cap diameter (mm)
let rise = 10.0; // [6.0, 14.0] Dome height (mm)
let R = (d * d / 4.0 + rise * rise) / (2.0 * rise);
let dome = (sphere([0, 0, rise - R], R) - sphere([0, 0, rise - R], R - 2.0)) & box_centered(d + 20.0, d + 20.0, 2.0 * rise).translate([0, 0, rise]);
let cap = dome - cylinder([0, 0, rise - 1.0], "Z", 9.0, 2.0);
let rl = d / 2.0 - 4.0;
let leg = box_from_corners([rl, -4.0, -12.0], [rl + 2.0, 4.0, 0.5]) + polygon([[rl + 2.0, 0, -12], [rl + 4.0, 0, -10], [rl + 2.0, 0, -7]]).to_face().extrude([0, 8.0, 0]).translate([0, -4.0, 0]);
let legs = [];
for k in 0..4 { legs.push(leg.rotate("Z", k.to_float() * 90.0)); }
fuse_all([cap] + legs)
