// Plastic duct reducer 125 to 100 mm: 124 mm OD spigot 40 mm, 45 mm cone, 99 mm OD spigot 40 mm, 1.8 mm wall, 2 mm stop bead at each collar root
let large_d = 124.0; // [110.0, 200.0] Large spigot outside diameter (mm)
let small_d = 99.0; // [60.0, 105.0] Small spigot outside diameter (mm)
let collar = 40.0; // [25.0, 80.0] Spigot length (mm)
let cone_len = 45.0; // [20.0, 100.0] Cone length (mm)
let wall = 1.8; // [1.2, 3.0] Wall thickness (mm)
const bead = 2.0;
let r1 = large_d / 2.0;
let r2 = small_d / 2.0;
let z1 = collar;
let z2 = collar + cone_len;
let z3 = z2 + collar;
let prof = polygon([
    [r1 - wall, 0, 0], [r1, 0, 0], [r1, 0, z1 - 4.0], [r1 + bead, 0, z1 - 3.0], [r1 + bead, 0, z1], [r1, 0, z1 + 1.0],
    [r2, 0, z2 - 1.0], [r2 + bead, 0, z2], [r2 + bead, 0, z2 + 3.0], [r2, 0, z2 + 4.0], [r2, 0, z3],
    [r2 - wall, 0, z3], [r2 - wall, 0, z2], [r1 - wall, 0, z1]]);
prof.to_face().revolve("Z", 360)
