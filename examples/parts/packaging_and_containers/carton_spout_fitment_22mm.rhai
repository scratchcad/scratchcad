// Gable-top carton spout fitment: 40 mm weld flange 1.5 mm thick, 22 mm spout 12 mm tall with an 18 mm bore and a 3 mm pitch external thread (1.5 turns), 0.4 mm tear-off membrane with a pull ring
let flange_diameter = 40.0; // [30.0, 55.0] Flange diameter (mm)
let spout_diameter = 22.0; // [15.0, 33.0] Spout root diameter (mm)
let spout_height = 12.0; // [8.0, 18.0] Spout height (mm)
let bore = 18.0; // [10.0, 28.0] Bore diameter (mm)
let ring_diameter = 10.0; // [6.0, 16.0] Pull ring diameter (mm)
const pitch = 3.0;
let rs = spout_diameter / 2.0;
let rb = min(bore / 2.0, rs - 1.2);
let rf = max(flange_diameter / 2.0, rs + 4.0);
let fit = cylinder(rf, 1.5).chamfer(0.5, ">Z") + cylinder([0, 0, 1.4], "Z", rs, spout_height - 1.4);
fit = fit - cylinder([0, 0, -1], "Z", rb, spout_height + 2.0);
let section = polygon([[rs - 0.3, 0, -0.7], [rs + 1.0, 0, -0.3], [rs + 1.0, 0, 0.3], [rs - 0.3, 0, 0.7]]);
let sections = [];
for i in 0..=18 {
    let t = i.to_float() / 12.0;
    sections.push(section.rotate_z(t * 360.0).translate([0, 0, spout_height - 6.0 + t * pitch]));
}
fit = fit + loft(sections, true);
// membrane across the bore with a thin score line, pull ring on a post
let membrane = cylinder([0, 0, 1.0], "Z", rb + 0.1, 0.4) - (cylinder([0, 0, 1.25], "Z", rb - 0.3, 0.3) - cylinder([0, 0, 1.0], "Z", rb - 0.6, 1.0));
let rr = min(ring_diameter / 2.0, rb - 1.5);
// the post stands on the membrane and carries the ring at its rim
let post = cylinder([rr - 0.6, 0, 1.3], "Z", 0.8, 3.5);
let pull_ring = cylinder([0, 0, 4.0], "Z", rr, 1.2) - cylinder([0, 0, 3.0], "Z", rr - 1.2, 3.0);
fuse_all([fit, membrane, post, pull_ring])
