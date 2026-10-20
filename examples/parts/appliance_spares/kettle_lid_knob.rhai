// Kettle lid knob: 35 x 20 mm oval grip 18 mm tall, 2 snap legs for a 4 mm lid slot, 10 mm stem
let length = 35.0; // [25.0, 50.0] Grip length (mm)
let width = 20.0; // [14.0, 30.0] Grip width (mm)
let height = 18.0; // [12.0, 28.0] Grip height (mm)
let grip = box_centered(length, width, height).translate([0, 0, height / 2.0 + 6.0]);
let g = grip.fillet(width / 2.0 - 0.5, grip.edges("|Z"));
let gg = g.fillet(4.0, g.edges(">Z"));
let stem = box_centered(10.0, 8.0, 7.0).translate([0, 0, 3.0]);
let legs = [];
for s in [-1.0, 1.0] { legs.push(box_from_corners([s * 2.0 - 0.75, -3.0, -6.0], [s * 2.0 + 0.75, 3.0, 0.01]) + box_from_corners([s * 2.0 - 0.75 + s * 0.8, -3.0, -6.0], [s * 2.0 + 0.75 + s * 0.8, 3.0, -4.5])); }
gg + stem + fuse_all(legs)
