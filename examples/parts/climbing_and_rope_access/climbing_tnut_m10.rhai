// Climbing wall M10 T-nut: 25 mm flange 1.5 mm thick, 12.5 mm barrel 13 mm long bored 8.5 mm (M10 tap drill), with four 6 mm prongs
let flange = 25.0; // [22.0, 30.0] Flange diameter (mm)
let barrel = 13.0; // [10.0, 20.0] Barrel length (mm)
const t = 1.5;
let f = cylinder([0, 0, 0], "Z", flange / 2.0, t);
let b = cylinder([0, 0, -barrel], "Z", 6.25, barrel + 0.01);
let prongs = [];
for i in 0..4 { prongs.push(box_from_corners([flange / 2.0 - 2.0, -1.25, -6.0], [flange / 2.0 - 0.8, 1.25, 0.01]).rotate_z(45.0 + 90.0 * i.to_float())); }
f + b + fuse_all(prongs) - cylinder([0, 0, -barrel - 1.0], "Z", 4.25, barrel + t + 2.0)
