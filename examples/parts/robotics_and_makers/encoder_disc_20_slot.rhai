// Optical wheel encoder disc for slot-type (H206/LM393) speed sensors: 25 mm disc 1.5 mm thick, 20 radial 2 x 5 mm slots, hub for a 5.4 mm TT motor D-shaft with 3.7 mm flats
let disc_d = 25.0; // [18.0, 50.0] Disc diameter (mm)
let slots = 20; // [8, 60] Number of slots
let slot_len = 5.0; // [2.0, 10.0] Slot length (mm)
let t = 1.5; // [1.0, 3.0] Disc thickness (mm)
const shaft = 5.4;
const flats = 3.7;
let rd = disc_d / 2.0;
let sl = min(slot_len, rd - 6.0);
let d = cylinder(rd, t) + cylinder([0, 0, t - 0.01], "Z", 5.0, 4.0);
let w = PI() * (rd - 1.5 - sl / 2.0) * 2.0 / slots.to_float() * 0.5;
let cuts = [];
for i in 0..slots { cuts.push(box_centered(w, sl, 4.0).translate([0, rd - 1.5 - sl / 2.0, 0]).rotate_z(i.to_float() * 360.0 / slots.to_float())); }
d -= fuse_all(cuts);
d - (cylinder([0, 0, -1], "Z", shaft / 2.0, 8.0) & box_centered(flats, shaft + 1.0, 20.0))
