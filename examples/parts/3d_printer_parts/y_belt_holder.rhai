// Y-axis belt holder: 30 x 12 mm base with two M3 holes 20 mm apart and a 15 mm tall toothed belt clamp post
let length = 30.0; // [20.0, 45.0] Base length (mm)
let width = 12.0; // [8.0, 20.0] Base width (mm)
let post_h = 15.0; // [8.0, 30.0] Post height (mm)
let base = box_centered(length, width, 3.0).translate([0, 0, 1.5]).fillet(2.0, "|Z");
let post = box_centered(8.0, 6.0, post_h).translate([0, 0, post_h / 2.0 + 2.99]);
let teeth = [];
for i in 0..6 { teeth.push(box_centered(1.0, 1.0, post_h - 2.0).translate([-2.5 + i.to_float() * 1.0 * 0.0, 3.0 + 0.4, post_h / 2.0 + 3.0]).translate([i.to_float() * 1.0 - 2.5, 0, 0])); }
let part = fuse_all([base, post]) - fuse_all(teeth);
for s in [-1, 1] { part -= cylinder([s * 10.0, 0, -1], "Z", 1.6, 5.0); }
part
