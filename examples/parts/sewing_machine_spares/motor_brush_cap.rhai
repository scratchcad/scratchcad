// Sewing motor carbon brush cap: 12 mm head 3 mm thick with a 1.2 x 8 mm screwdriver slot 1.2 mm deep, 9 mm threaded spigot (plain cylinder) 6 mm long, 6.2 mm blind bore 5 mm deep for the brush spring
let head_d = 12.0; // [10.0, 16.0] Head diameter (mm)
let head_t = 3.0; // [2.0, 4.0] Head thickness (mm)
let spigot_d = 9.0; // [7.0, 11.0] Spigot diameter (mm)
let spigot_len = 6.0; // [4.0, 9.0] Spigot length (mm)
const spring_bore = 6.2;
let head = cylinder([0, 0, spigot_len], "Z", head_d / 2.0, head_t);
let head = head.chamfer(0.5, head.edges(">Z"));
let spigot = cylinder([0, 0, 0], "Z", spigot_d / 2.0, spigot_len + 0.5);
let sb = min(spring_bore, spigot_d - 2.0);
let depth = min(5.0, spigot_len + head_t - 1.5);
(head + spigot) - fuse_all([
    cylinder([0, 0, -1.0], "Z", sb / 2.0, depth + 1.0),
    box_centered(8.0, 1.2, 2.4).translate([0, 0, spigot_len + head_t]),
])
