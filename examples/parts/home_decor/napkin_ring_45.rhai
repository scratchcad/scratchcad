// Napkin ring: 45 mm ID, 30 mm wide, 3 mm wall, scalloped edges with 16 lobes
let id = 45.0; // [35.0, 60.0] Inside diameter (mm)
let width = 30.0; // [15.0, 45.0] Width (mm)
let wall = 3.0; // [2.0, 5.0] Wall (mm)
let ring = cylinder(id / 2.0 + wall, width) - cylinder([0, 0, -1], "Z", id / 2.0, width + 2.0);
let scallops = [];
for k in 0..8 { for z in [0.0, width] { scallops.push(cylinder([-id, 0, z], "X", 4.0, 2.0 * id).rotate_z(k.to_float() * 22.5)); } }
ring - fuse_all(scallops)
