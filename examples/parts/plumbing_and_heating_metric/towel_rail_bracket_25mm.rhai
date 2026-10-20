// Heated towel rail wall bracket for 25 mm tube: 50 mm wall rose 6 mm thick, 22 mm stem 35 mm long, 34 mm ring collar 14 mm wide with 25.4 mm bore, M4 grub screw hole, 3 screw holes
let tube = 25.4; // [19.0, 32.0] Rail tube diameter (mm)
let standoff = 35.0; // [20.0, 70.0] Wall standoff (mm)
let rose_d = 50.0; // [40.0, 70.0] Wall rose diameter (mm)
let stem_d = 22.0; // [16.0, 30.0] Stem diameter (mm)
let collar_w = 14.0; // [10.0, 20.0] Collar width (mm)
let rt = tube / 2.0 + 0.1;
let rc = rt + 4.0;
let rose = cylinder(rose_d / 2.0, 6.0);
let rose = rose.chamfer(1.5, rose.edges(">Z"));
let ztop = 6.0 + standoff;
let stem = cylinder([0, 0, 5.0], "Z", min(stem_d, rc * 2.0 - 2.0) / 2.0, ztop - 5.0);
let collar = cylinder([0, -collar_w / 2.0, ztop + rc - 2.0], "Y", rc, collar_w);
let body = rose + stem + collar;
let holes = [];
for k in 0..3 {
    let a = (k.to_float() * 120.0 + 90.0) * PI() / 180.0;
    let rp = rose_d / 2.0 - 5.5;
    holes.push(cylinder([rp * a.cos(), rp * a.sin(), -1], "Z", 2.1, 10.0));
}
body - cylinder([0, -collar_w, ztop + rc - 2.0], "Y", rt, collar_w * 2.0) - compound(holes) - cylinder([0, 0, ztop - 5.0], "Z", 1.7, rc * 3.0)
