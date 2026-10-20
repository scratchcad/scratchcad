// Press-stud (snap fastener) socket, 12.5 mm: 0.6 mm flange, 6 mm socket boss 2.4 mm tall with a 3.5 mm sprung lip for a 4 mm stud head, four spring slits
let flange_diameter = 12.5; // [8.0, 20.0] Flange diameter (mm)
let boss_diameter = 6.0; // [4.5, 9.0] Socket boss diameter (mm)
let stud_head = 4.0; // [3.0, 6.0] Stud head diameter (mm)
let boss_height = 2.4; // [1.5, 4.0] Boss height above the flange (mm)
let slits = 4; // [0, 8] Number of spring slits
let rf = flange_diameter / 2.0;
let rbo = min(boss_diameter / 2.0, rf - 0.5);
let rs = min(stud_head / 2.0, rbo - 0.6);
let rl = rs - 0.25;
let zt = 0.6 + boss_height;
let profile = sketch("XZ")
    .move_to(rs, 0)
    .hline_to(rf)
    .vline_to(0.6)
    .hline_to(rbo)
    .vline_to(zt)
    .hline_to(rl)
    .vline_to(zt - 0.5)
    .line_to(rs, zt - 0.9)
    .close();
let socket = profile.to_face().revolve("Z", 360);
let cuts = [];
for i in 0..slits {
    cuts.push(box_from_corners([rl - 0.5, -0.25, 1.2], [rbo + 0.5, 0.25, zt + 1.0]).rotate_z(i.to_float() * 360.0 / slits.to_float()));
}
if slits > 0 { socket = socket - compound(cuts); }
socket
