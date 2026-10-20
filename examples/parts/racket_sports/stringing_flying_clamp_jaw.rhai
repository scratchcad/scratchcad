// Racket stringing flying clamp jaw: 30 x 10 x 8 mm jaw with 8 serrations 0.6 mm deep across the grip face, a 1.4 mm string channel and a 4 mm pivot pin bore
let length = 30.0; // [22.0, 40.0] Jaw length (mm)
let teeth = 8; // [4, 14] Number of serrations
const w = 10.0;
const h = 8.0;
let j = box_from_corners([0, 0, 0], [length, w, h]);
let cuts = [cylinder([-1.0, w / 2.0, h], "X", 0.7, length + 2.0), cylinder([length - 5.0, -1.0, h / 2.0], "Y", 2.0, w + 2.0)];
for i in 0..teeth { cuts.push(box_centered(1.0, w + 2.0, 1.2).rotate_x(0.0).rotate_y(45.0).translate([2.5 + i.to_float() * (length - 12.0) / teeth.to_float(), w / 2.0, h])); }
j - fuse_all(cuts)
