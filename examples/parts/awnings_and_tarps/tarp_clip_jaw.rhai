// Tarp clip: 45 x 25 mm clamp jaw pair with a 10 mm rope eye, 3 mm grip teeth (two jaws, two solids)
let length = 45.0; // [40.0, 60.0] Jaw length (mm)
let width = 25.0; // [18.0, 35.0] Jaw width (mm)
let t = 4.0; // [3.0, 6.0] Jaw thickness (mm)
let jaw = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, t]);
let teeth = [];
for k in 0..6 { teeth.push(box_from_corners([8.0 + k.to_float() * 5.0, -width / 2.0, t - 0.01], [10.0 + k.to_float() * 5.0, width / 2.0, t + 1.5])); }
let eye = cylinder([-6.0, 0, 0], "Z", 8.0, t) - cylinder([-6.0, 0, -1], "Z", 5.0, t + 2.0) + box_from_corners([-2.0, -6.0, 0], [0.01, 6.0, t]);
let a = jaw + fuse_all(teeth) + eye;
let b = a.mirror([0, 0, 1]).translate([0, 0, 2.0 * t + 3.5]);
compound([a, b])
