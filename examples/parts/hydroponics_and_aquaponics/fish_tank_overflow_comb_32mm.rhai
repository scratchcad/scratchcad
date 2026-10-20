// Aquaponics fish tank overflow comb strainer for a 32 mm standpipe: push-on sleeve 38 mm OD, 3 mm wall, 70 mm tall with a closed 3 mm top, and 12 vertical comb slots 4 mm wide and 40 mm tall around the upper part
let pipe_od = 32.0; // [20.0, 50.0] Standpipe outside diameter (mm)
let height = 70.0; // [45.0, 120.0] Strainer height (mm)
let slots = 12; // [6, 20] Number of comb slots
let slot_len = 40.0; // [15.0, 60.0] Slot length (mm)
const wall = 3.0;
let ri = pipe_od / 2.0 + 0.2;
let ro = ri + wall;
let body = cylinder([0, 0, 0], "Z", ro, height) - cylinder([0, 0, -1.0], "Z", ri, height - wall + 1.0);
let sl = min(slot_len, height - wall - 15.0);
let sw = min(4.0, 0.45 * 2.0 * PI() * ri / slots.to_float());
let cuts = [];
for i in 0..slots {
    cuts.push(box_from_corners([ri - 1.0, -sw / 2.0, height - wall - 3.0 - sl], [ro + 1.0, sw / 2.0, height - wall - 3.0]).rotate_z(i.to_float() * 360.0 / slots.to_float()));
}
body - fuse_all(cuts)
