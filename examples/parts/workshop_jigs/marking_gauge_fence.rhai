// Wheel marking gauge fence: 65 mm disc 16 mm thick, 3/8 in (9.6 mm) beam bore, 13 mm thumb-screw boss with an M6 tap hole, 2 mm wear-strip recess 45 mm across on the face
let fence_d = 65.0; // [45.0, 90.0] Fence diameter (mm)
let t = 16.0; // [10.0, 25.0] Fence thickness (mm)
let beam_d = 9.6; // [8.0, 16.0] Beam bore (mm)
let boss_h = 10.0; // [6.0, 16.0] Thumb-screw boss height (mm)
let r = fence_d / 2.0;
let disc = cylinder([0, 0, 0], "Y", r, t);
let d = disc.chamfer(1.0);
let boss_r = min(6.5, t / 2.0 - 1.5);
let boss = cylinder([0, t / 2.0, r - 3.0], "Z", boss_r, boss_h + 3.0);
let recess = cylinder([0, t - 2.0, 0], "Y", 22.5, 3.0) - cylinder([0, t - 3.0, 0], "Y", beam_d / 2.0 + 3.0, 5.0);
d + boss - cylinder([0, -1, 0], "Y", beam_d / 2.0, t + 2.0) - recess - cylinder([0, t / 2.0, 0], "Z", 2.5, r + boss_h + 1.0)
