// Hydraulic brake bleed funnel: 30 mm conical cup 40 mm tall with 1.5 mm walls, 7 mm spigot 6 mm long (plain, for an M7 bleed port) and a 3 mm oil passage through
let cup_d = 30.0; // [22.0, 40.0] Cup top diameter (mm)
let height = 40.0; // [30.0, 60.0] Overall height (mm)
let spigot_d = 7.0; // [6.0, 9.0] Spigot diameter (mm)
let spigot_len = 6.0; // [4.0, 10.0] Spigot length (mm)
const wall = 1.5;
const passage = 3.0;
let ro = cup_d / 2.0;
let rs = spigot_d / 2.0;
let rp = passage / 2.0;
let z1 = spigot_len + 2.0;
let profile = polygon([
    [rp, 0, 0], [rs, 0, 0], [rs, 0, spigot_len], [rs + 4.5, 0, z1],
    [ro, 0, height - 2.0], [ro, 0, height], [ro - wall, 0, height],
    [rs + 3.0, 0, z1 + 2.0], [rp, 0, z1 + 1.0]
]);
profile.to_face().revolve("Z", 360.0)
