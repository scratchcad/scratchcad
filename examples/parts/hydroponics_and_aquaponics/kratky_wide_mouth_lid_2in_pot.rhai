// Kratky wide-mouth mason jar insert lid: 86 mm disc 3 mm thick that sits under the screw band, a 74 mm locating ring 5 mm deep underneath, a 52 mm hole for a 2 inch net pot with a 4 mm raised collar 3 mm wide, and two 6 mm air vents
let jar_mouth = 86.0; // [70.0, 100.0] Lid disc diameter (mm)
let pot_hole = 52.0; // [36.0, 60.0] Net pot hole diameter (mm)
let collar_h = 4.0; // [0.0, 10.0] Collar height (mm)
let vent_d = 6.0; // [3.0, 8.0] Air vent diameter (mm)
const t = 3.0;
let rd = jar_mouth / 2.0;
let rl = rd - 6.0;
let rh = min(pot_hole / 2.0, rl - vent_d - 6.0);
let disc = cylinder([0, 0, 0], "Z", rd, t);
let ring = cylinder([0, 0, -5.0], "Z", rl, 5.5) - cylinder([0, 0, -6.0], "Z", rl - 2.0, 6.0);
let parts = [disc, ring];
if collar_h > 0.1 {
    parts.push(cylinder([0, 0, t - 0.5], "Z", rh + 3.0, collar_h + 0.5));
}
let lid = fuse_all(parts);
let vx = (rh + 3.0 + rl - 2.0) / 2.0;
let cuts = [cylinder([0, 0, -1.0], "Z", rh, t + collar_h + 2.0)];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([s * vx, 0, -1.0], "Z", vent_d / 2.0, t + 2.0));
}
lid - fuse_all(cuts)
