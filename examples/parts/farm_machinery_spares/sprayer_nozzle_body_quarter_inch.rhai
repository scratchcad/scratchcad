// Sprayer nozzle body, 1/4 inch BSP inlet with bayonet outlet: 22 mm hex 10 mm thick, a 13.16 mm (1/4 BSP major diameter) inlet spigot 10 mm long with a 1 mm chamfer, a 6 mm inlet bore, and an 18 mm bayonet boss 8 mm tall with two 4 mm wide lugs standing 2.5 mm proud and an 8 mm outlet bore
let hex_af = 22.0; // [17.0, 27.0] Hex across flats (mm)
let hex_h = 10.0; // [6.0, 14.0] Hex height (mm)
let spigot_d = 13.16; // [9.73, 16.66] Inlet thread diameter (mm)
let spigot_len = 10.0; // [6.0, 16.0] Inlet length (mm)
let boss_d = 18.0; // [14.0, 22.0] Bayonet boss diameter (mm)
const boss_h = 8.0;
const lug_w = 4.0;
const lug_proud = 2.5;
const lug_t = 2.5;
let rh = hex_af / 2.0 / cos(30.0 * PI() / 180.0);
let hex = polygon([0, 60, 120, 180, 240, 300].map(|a| [rh * cos(a * PI() / 180.0), rh * sin(a * PI() / 180.0), 0])).to_face().extrude([0, 0, hex_h]);
let spigot = cylinder([0, 0, -spigot_len], "Z", spigot_d / 2.0, spigot_len + 0.5);
let spigot = spigot.chamfer(1.0, spigot.edges("<Z"));
let rb = min(boss_d / 2.0, hex_af / 2.0);
let parts = [hex, spigot, cylinder([0, 0, hex_h - 0.5], "Z", rb, boss_h + 0.5)];
for s in [0.0, 180.0] {
    parts.push(box_from_corners([rb - 0.5, -lug_w / 2.0, hex_h + boss_h - lug_t - 1.0], [rb + lug_proud, lug_w / 2.0, hex_h + boss_h - 1.0]).rotate_z(s));
}
let body = fuse_all(parts);
body - fuse_all([
    cylinder([0, 0, -spigot_len - 1.0], "Z", 3.0, spigot_len + hex_h + 2.0),
    cylinder([0, 0, hex_h], "Z", 4.0, boss_h + 1.0),
])
