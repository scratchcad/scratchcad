// Horseshoe, size 1 front: 125 x 130 mm, 22 mm web, 8 mm thick, fullered groove 3 mm with 8 nail holes 4 x 5 mm
let length = 130.0; // [100.0, 160.0] Shoe length (mm)
let width = 125.0; // [100.0, 160.0] Shoe width (mm)
let web = 22.0; // [16.0, 28.0] Web width (mm)
let t = 8.0; // [6.0, 12.0] Thickness (mm)
let r = width / 2.0;
let outer = cylinder([0, length - r, 0], "Z", r, t) + box_from_corners([-r, 0, 0], [r, length - r, t]);
let inner = cylinder([0, length - r, -1], "Z", r - web, t + 2.0) + box_from_corners([-r + web, -1, -1], [r - web, length - r, t + 1.0]);
let shoe = outer - inner;
let groove = (cylinder([0, length - r, t - 3.0], "Z", r - web / 2.0 + 1.5, 4.0) - cylinder([0, length - r, t - 4.0], "Z", r - web / 2.0 - 1.5, 6.0)) & box_from_corners([-r, 20.0, -1], [r, length + 1.0, t + 2.0]);
let holes = [];
for k in 0..4 { for s in [-1.0, 1.0] { let a = (s * (25.0 + k.to_float() * 22.0) + 90.0) * PI() / 180.0; holes.push(box_centered(4.0, 5.0, t * 3.0).rotate_z(a * 180.0 / PI()).translate([(r - web / 2.0) * a.cos(), length - r + (r - web / 2.0) * a.sin(), 0])); } }
shoe - groove - compound(holes)
