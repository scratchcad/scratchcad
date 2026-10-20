// Hay rake wheel hub dust cap: press-in cap with a 47 mm spigot 10 mm long and 0.8 mm lead-in chamfer, a 54 mm flange 2.5 mm thick, and a conical crown rising 6 mm to a 30 mm flat top, all 1.8 mm wall, hollow inside to clear the axle nut
let spigot_d = 47.0; // [35.0, 62.0] Spigot diameter (mm)
let spigot_len = 10.0; // [6.0, 16.0] Spigot length (mm)
let flange_d = 54.0; // [40.0, 72.0] Flange diameter (mm)
let crown_h = 6.0; // [3.0, 12.0] Crown height (mm)
let top_d = 30.0; // [20.0, 40.0] Crown top diameter (mm)
const t = 1.8;
const flange_t = 2.5;
let rs = spigot_d / 2.0;
let rf = max(flange_d / 2.0, rs + 3.0);
let rt = min(top_d / 2.0, rs - 4.0);
let z1 = spigot_len;
let z2 = z1 + flange_t;
let z3 = z2 + crown_h;
let profile = polygon([
    [rs - t, 0, 0], [rs - 0.8, 0, 0], [rs, 0, 0.8], [rs, 0, z1], [rf, 0, z1], [rf, 0, z2],
    [rf - 1.0, 0, z2], [rt, 0, z3], [0, 0, z3], [0, 0, z3 - t], [rt - 0.6, 0, z3 - t],
    [rs - t, 0, z2 - 0.5],
]);
profile.to_face().revolve("Z", 360.0)
