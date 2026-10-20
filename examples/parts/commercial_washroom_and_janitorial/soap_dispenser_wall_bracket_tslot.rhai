// Commercial soap dispenser wall bracket: 80 x 120 mm back plate 4 mm thick with 5 mm corner radii, two vertical T-section rails 6 mm proud (6 mm stems, 12 mm lips 3 mm thick) that the dispenser slides down onto, a 10 mm end stop at the bottom, and four 4.5 mm countersunk screw holes
let width = 80.0; // [60.0, 120.0] Plate width (mm)
let height = 120.0; // [80.0, 200.0] Plate height (mm)
let rail_spacing = 50.0; // [30.0, 90.0] Rail spacing (mm)
const t = 4.0;
const stem_w = 6.0;
const lip_w = 12.0;
const rail_h = 6.0;
let plate = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, t, height]);
let plate = plate.fillet(5.0, plate.edges("|Y"));
let rs = min(rail_spacing, width - lip_w - 6.0);
let parts = [plate];
for s in [-1.0, 1.0] {
    let x = s * rs / 2.0;
    parts.push(box_from_corners([x - stem_w / 2.0, t - 0.5, 10.0], [x + stem_w / 2.0, t + rail_h - 3.0, height - 8.0]));
    parts.push(box_from_corners([x - lip_w / 2.0, t + rail_h - 3.0, 10.0], [x + lip_w / 2.0, t + rail_h, height - 8.0]));
}
parts.push(box_from_corners([-rs / 2.0 - lip_w / 2.0, t - 0.5, 0], [rs / 2.0 + lip_w / 2.0, t + rail_h, 10.0]));
let body = fuse_all(parts);
let cuts = [];
for z in [20.0, height - 20.0] {
    cuts.push(cylinder([0, -1.0, z], "Y", 2.25, t + 2.0));
    cuts.push(cone(2.25, 4.5, 2.25).rotate_x(-90.0).translate([0, t - 2.24, z]));
}
for z in [height * 0.4, height * 0.6] {
    cuts.push(cylinder([0, -1.0, z], "Y", 2.25, t + 2.0));
    cuts.push(cone(2.25, 4.5, 2.25).rotate_x(-90.0).translate([0, t - 2.24, z]));
}
(body - fuse_all(cuts)).mirror("XZ")
