// Fan anti-vibration rubber mount type A 25 x 20 M6: 25 mm rubber body 20 mm tall with a waist, 1.5 mm steel discs bonded top and bottom, 6 mm studs 15 mm long both ends
let body_d = 25.0; // [15.0, 50.0] Rubber body diameter (mm)
let height = 20.0; // [10.0, 40.0] Rubber height (mm)
let waist = 0.85; // [0.7, 0.95] Waist diameter relative to the body
let stud_d = 6.0; // [4.0, 10.0] Stud diameter (mm)
let stud_l = 15.0; // [8.0, 25.0] Stud length (mm)
const disc_t = 1.5;
let r = body_d / 2.0;
let rw = r * waist;
let rubber = cone(r, rw, height / 2.0) + cone(rw, r, height / 2.0).translate([0, 0, height / 2.0]);
let discs = cylinder([0, 0, -disc_t], "Z", r, disc_t + 0.1) + cylinder([0, 0, height - 0.1], "Z", r, disc_t + 0.1);
let rs = min(stud_d / 2.0, r * 0.6);
let studs = cylinder([0, 0, -disc_t - stud_l], "Z", rs, stud_l + 0.5) + cylinder([0, 0, height + disc_t - 0.5], "Z", rs, stud_l + 0.5);
let mount = fuse_all([rubber, discs, studs]);
mount.chamfer(rs * 0.15, mount.edges("%CIRCLE").filter(|e| e.radius() < rs + 0.01 && (e.center().z < -disc_t - stud_l + 0.01 || e.center().z > height + disc_t + stud_l - 0.01)))
