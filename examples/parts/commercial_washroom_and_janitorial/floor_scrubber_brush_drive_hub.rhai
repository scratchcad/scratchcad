// Floor scrubber brush drive hub: 100 mm disc 8 mm thick with six 6 mm bolt holes on a 76 mm circle, a 40 mm boss 15 mm tall with a 3-lug bayonet (three 10 x 6 mm lugs 4 mm thick) to lock the brush, and a 20 mm motor shaft bore with a 6 mm key slot
let disc_d = 100.0; // [80.0, 150.0] Disc diameter (mm)
let boss_d = 40.0; // [30.0, 60.0] Boss diameter (mm)
let shaft_d = 20.0; // [12.0, 28.0] Shaft diameter (mm)
let bolts = 6; // [3, 8] Number of bolt holes
const t = 8.0;
const boss_h = 15.0;
let rd = disc_d / 2.0;
let rbs = max(boss_d / 2.0, shaft_d / 2.0 + 6.0);
let rbs = min(rbs, rd - 16.0);
let disc = cylinder([0, 0, 0], "Z", rd, t);
let disc = disc.chamfer(1.0, disc.edges(">Z"));
let boss = cylinder([0, 0, t - 0.5], "Z", rbs, boss_h + 0.5);
let parts = [disc, boss];
for i in 0..3 {
    parts.push(box_from_corners([rbs - 1.0, -5.0, t + boss_h - 4.0], [rbs + 6.0, 5.0, t + boss_h]).rotate_z(i.to_float() * 120.0));
}
let body = fuse_all(parts);
let sr = min(shaft_d / 2.0, rbs - 5.0);
let pcd = (rd + rbs + 6.0) / 2.0;
let cuts = [cylinder([0, 0, -1.0], "Z", sr, t + boss_h + 2.0), box_from_corners([sr - 1.0, -3.0, -1.0], [sr + 2.5, 3.0, t + boss_h + 1.0])];
for i in 0..bolts {
    let a = (i.to_float() * 360.0 / bolts.to_float() + 30.0) * PI() / 180.0;
    cuts.push(cylinder([pcd * cos(a), pcd * sin(a), -1.0], "Z", 3.0, t + 2.0));
}
body - fuse_all(cuts)
