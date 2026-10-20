// Net pot reducer ring, 3 inch to 2 inch: an 89.5 mm flange 3 mm thick with a 52 mm hole for a 2 inch net pot, and a 75.5 mm locating spigot 8 mm deep with a 2 mm wall that drops into a 3 inch (76 mm) lid hole
let lid_hole = 76.0; // [60.0, 100.0] Lid hole diameter (mm)
let pot_hole = 52.0; // [35.0, 60.0] Net pot hole diameter (mm)
let flange_w = 7.0; // [4.0, 15.0] Flange overlap (mm)
let spigot_depth = 8.0; // [4.0, 15.0] Spigot depth (mm)
const t = 3.0;
const wall = 2.0;
let rs = lid_hole / 2.0 - 0.25;
let rf = rs + flange_w;
let rh = min(pot_hole / 2.0, rs - wall - 3.0);
let pts = [[rh, 0, 0], [rs - wall, 0, 0], [rs - wall, 0, -spigot_depth], [rs - 0.5, 0, -spigot_depth], [rs, 0, -spigot_depth + 0.5], [rs, 0, 0], [rf - 1.0, 0, 0], [rf, 0, 1.0], [rf, 0, t], [rh, 0, t]];
face(polygon(pts)).revolve("Z", 360.0)
