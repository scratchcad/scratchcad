// Bronze rowlock: U horn 55 mm wide inside and 50 mm deep on a 12.7 mm shank 60 mm long, 8 mm rod section, lanyard hole
let w = 55.0; // [45.0, 70.0] Inside width (mm)
let rod = 8.0; // [6.0, 12.0] Rod diameter (mm)
let r = rod / 2.0;
let bottom = (torus(w / 2.0 + r, r) & box_from_corners([-w, -w, -r * 2.0], [w, 0, r * 2.0])).rotate_x(90.0);
let horns = [cylinder([-w / 2.0 - r, 0, 0], "Z", r, 30.0), cylinder([w / 2.0 + r, 0, 0], "Z", r, 30.0), sphere([-w / 2.0 - r, 0, 30.0], r * 1.2), sphere([w / 2.0 + r, 0, 30.0], r * 1.2)];
let shank = cylinder([0, 0, -w / 2.0 - 60.0], "Z", 6.35, 60.0 + r) - cylinder([0, -8.0, -w / 2.0 - 52.0], "Y", 1.6, 16.0);
fuse_all([bottom, shank] + horns)
