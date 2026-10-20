// PTFE magnetic stir bar 40 x 8 mm: capsule with a 9 mm pivot ring at the centre
let len = 40.0; // [10.0, 80.0] Length (mm)
let d = 8.0; // [3.0, 12.0] Diameter (mm)
let r = d / 2.0;
fuse_all([cylinder([-len / 2.0 + r, 0, 0], "X", r, len - d), sphere([-len / 2.0 + r, 0, 0], r), sphere([len / 2.0 - r, 0, 0], r), torus(r, 0.6).rotate_y(90.0)])
