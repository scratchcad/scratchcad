// 70 mm porcelain Buchner funnel: 45 mm cup with 4 mm wall, perforated plate with 37 holes, conical base to a 12 mm stem 40 mm long
let d = 70.0; // [40.0, 150.0] Plate diameter (mm)
let r = d / 2.0;
let cup = cylinder([0, 0, 15.0], "Z", r + 4.0, 45.0) - cylinder([0, 0, 18.0], "Z", r, 45.0);
let base = cone(6.0, r + 4.0, 15.0) - cone(4.0, r - 2.0, 15.0).translate([0, 0, -0.01]);
let stem = cylinder([0, 0, -40.0], "Z", 6.0, 40.5) - cylinder([0, 0, -41.0], "Z", 4.0, 42.0);
let f = fuse_all([cup, base, stem]);
let holes = [cylinder([0, 0, 10.0], "Z", 1.0, 12.0)];
for ring in [[r * 0.3, 6], [r * 0.55, 12], [r * 0.8, 18]] { for k in 0..ring[1] { holes.push(cylinder([ring[0], 0, 10.0], "Z", 1.0, 12.0).rotate("Z", k.to_float() * 360.0 / ring[1].to_float())); } }
f - fuse_all(holes)
