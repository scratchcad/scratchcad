// Bathroom extractor fan outlet adapter: 100.5 mm socket 25 mm deep over a 100 mm fan spigot, 3 mm stop shoulder, 60 mm transition to 110 x 54 mm flat channel duct with a 30 mm spigot, 2 mm wall
let socket_d = 100.5; // [80.0, 130.0] Socket inside diameter (mm)
let socket_depth = 25.0; // [15.0, 40.0] Socket depth (mm)
let duct_w = 110.0; // [90.0, 220.0] Flat duct width (mm)
let duct_h = 54.0; // [40.0, 70.0] Flat duct height (mm)
let transition = 60.0; // [40.0, 120.0] Transition length (mm)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
const spigot_l = 30.0;
const shoulder = 3.0;
let rs = socket_d / 2.0;
let z1 = socket_depth;
let z2 = z1 + transition;
let z3 = z2 + spigot_l;
// flat spigot fits inside the flat duct, so it is the duct size minus the clearance
let sw = duct_w - 1.0;
let sh = duct_h - 1.0;
let outer = fuse_all([
    cylinder(rs + wall, z1),
    loft([circle(plane([0, 0, z1], [0, 0, 1]), rs + wall), rect(plane([0, 0, z2], [0, 0, 1]), sw, sh)], true),
    box_centered(sw, sh, spigot_l).translate([0, 0, z2 + spigot_l / 2.0])]);
let hollow = fuse_all([
    cylinder([0, 0, -1], "Z", rs, z1 + 1.0),
    loft([circle(plane([0, 0, z1], [0, 0, 1]), rs - shoulder), rect(plane([0, 0, z2], [0, 0, 1]), sw - 2.0 * wall, sh - 2.0 * wall)], true),
    box_centered(sw - 2.0 * wall, sh - 2.0 * wall, spigot_l + 2.0).translate([0, 0, z2 + spigot_l / 2.0 + 1.0])]);
outer - hollow
