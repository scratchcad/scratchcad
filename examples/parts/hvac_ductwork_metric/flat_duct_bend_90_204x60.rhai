// Horizontal 90 degree bend for 204 x 60 mm flat channel duct: 2 mm wall, 40 mm inner radius, 40 mm straight spigots on both ends sized to slide into the duct
let duct_w = 204.0; // [110.0, 250.0] Duct width (mm)
let duct_h = 60.0; // [40.0, 90.0] Duct height (mm)
let inner_r = 40.0; // [20.0, 120.0] Inner bend radius (mm)
let spigot = 40.0; // [20.0, 80.0] Straight spigot length (mm)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
let w = duct_w - 1.0;
let h = duct_h - 1.0;
let x0 = inner_r;
let x1 = inner_r + w;
let outer = polygon([[x0, 0, 0], [x1, 0, 0], [x1, 0, h], [x0, 0, h]]);
let inner = polygon([[x0 + wall, 0, wall], [x1 - wall, 0, wall], [x1 - wall, 0, h - wall], [x0 + wall, 0, h - wall]]);
let section = face(outer, [inner]);
let bend = section.revolve([0, 0, 0], "Z", 90.0);
let leg_a = section.extrude([0, -spigot, 0]);
let leg_b = section.rotate_z(90.0).extrude([-spigot, 0, 0]);
fuse_all([bend, leg_a, leg_b])
