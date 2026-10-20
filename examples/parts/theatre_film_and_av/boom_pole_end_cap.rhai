// Boom pole end cap: rubber-style cap for a 32 mm boom pole section, 34 mm OD 30 mm long, 2 mm wall, 4 mm end with a 12 mm hole for a 3/8-16 brass insert, 8 grip ribs 1 mm proud
let pole = 32.0; // [20.0, 45.0] Pole diameter (mm)
let length = 30.0; // [15.0, 50.0] Cap length (mm)
let wall = 2.0; // [1.5, 3.5] Wall thickness (mm)
let end_t = 4.0; // [3.0, 8.0] End thickness (mm)
let ribs = 8; // [4, 16] Number of grip ribs
let r = pole / 2.0 + wall;
let cap = cylinder(r, length) - cylinder([0, 0, end_t], "Z", pole / 2.0, length);
let c = cap.chamfer(1.0, cap.edges("<Z"));
let rs = [];
for k in 0..ribs { rs.push(box_centered(2.0, 2.0, length - 8.0).translate([r, 0, length / 2.0 + 2.0]).rotate_z(k.to_float() * 360.0 / ribs.to_float())); }
c + fuse_all(rs) - cylinder([0, 0, -1.0], "Z", 6.0, end_t + 1.0 + 3.0)
