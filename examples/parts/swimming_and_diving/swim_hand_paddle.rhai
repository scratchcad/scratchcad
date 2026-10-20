// Swim training hand paddle: 200 x 160 mm teardrop-ish plate 3 mm thick from straight segments, with 9 water holes 10 mm and two finger strap slot pairs 4 x 18 mm
let length = 200.0; // [150.0, 250.0] Paddle length (mm)
let width = 160.0; // [110.0, 190.0] Paddle width (mm)
const t = 3.0;
let p = face(polygon([[0, 0, 0], [width * 0.35, length * 0.05, 0], [width * 0.5, length * 0.35, 0], [width * 0.45, length * 0.75, 0], [width * 0.2, length, 0], [-width * 0.2, length, 0], [-width * 0.45, length * 0.75, 0], [-width * 0.5, length * 0.35, 0], [-width * 0.35, length * 0.05, 0]])).extrude([0, 0, t]);
let cuts = [];
for i in 0..3 { for j in 0..3 { cuts.push(cylinder([(i.to_float() - 1.0) * width * 0.25, length * (0.25 + 0.2 * j.to_float()), -1.0], "Z", 5.0, t + 2.0)); } }
for y in [length * 0.82, length * 0.12] { for x in [-width * 0.15, width * 0.15] { cuts.push(box_centered(4.0, 18.0, t + 2.0).rotate_z(90.0).translate([x, y, t / 2.0])); } }
p - fuse_all(cuts)
