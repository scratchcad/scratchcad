// Snap-in PCB support for 3.2 mm holes, 1.6 mm boards: 7 mm shoulders at both ends of a 4 mm post 8 mm tall, arrow-head snap tips both ends (3.9 mm barb, 2.6 mm neck), slit 0.8 mm through each tip
let post_h = 8.0; // [4.0, 20.0] Board spacing (mm)
let post_d = 4.0; // [3.0, 6.0] Post diameter (mm)
let flange_d = 7.0; // [5.0, 10.0] Flange diameter (mm)
let hole = 3.2; // [2.5, 4.0] Board hole diameter (mm)
let pcb = 1.6; // [0.8, 2.4] Board thickness (mm)
let rn = hole / 2.0 - 0.3;
let rb = hole / 2.0 + 0.35;
let pd = max(post_d, hole + 0.6);
let rf = max(flange_d / 2.0, pd / 2.0 + 1.0);
let post = cylinder([0, 0, 0], "Z", pd / 2.0, post_h) + cylinder([0, 0, post_h - 1.0], "Z", rf, 1.0) + cylinder(rf, 1.0);
let tips = [];
for s in [-1.0, 1.0] {
    let z0 = if s > 0.0 { post_h } else { 0.0 };
    let neck = cylinder([0, 0, z0 - s * 0.3], [0, 0, s], rn, pcb + 0.3);
    let barb = cone(rb, rn * 0.6, 2.2).translate([0, 0, z0 + s * pcb]);
    let barb = if s > 0.0 { barb } else { cone(rn * 0.6, rb, 2.2).translate([0, 0, -pcb - 2.2]) };
    tips.push(neck + barb);
}
let slit_top = box_from_corners([-0.4, -rb - 1.0, post_h + 0.3], [0.4, rb + 1.0, post_h + pcb + 3.0]);
let slit_bot = box_from_corners([-0.4, -rb - 1.0, -pcb - 3.0], [0.4, rb + 1.0, -0.3]);
fuse_all([post] + tips) - slit_top - slit_bot
