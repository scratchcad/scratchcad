// Utensil crock divider insert: fits a 120 mm round crock, 3-way Y divider 100 mm tall, 2 mm walls
let crock = 120.0; // [90.0, 160.0] Crock inside diameter (mm)
let height = 100.0; // [60.0, 150.0] Divider height (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let blades = [];
for k in 0..3 { blades.push(box_from_corners([0, -wall / 2.0, 0], [crock / 2.0 - 1.0, wall / 2.0, height]).rotate_z(k.to_float() * 120.0 + 90.0)); }
let hub = cylinder(5.0, height);
let rim = cylinder([0, 0, height - 6.0], "Z", crock / 2.0 - 1.0, 6.0) - cylinder([0, 0, height - 7.0], "Z", crock / 2.0 - 1.0 - wall, 8.0);
fuse_all(blades) + hub + rim
