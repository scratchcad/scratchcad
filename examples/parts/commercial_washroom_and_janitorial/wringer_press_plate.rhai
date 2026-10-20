// Down-press mop wringer press plate: 250 x 120 mm plate 5 mm thick with 8 mm corner radii, nine 8 mm drain slots 90 mm long, three 4 x 8 mm stiffening ribs underneath across the slots, and two 10 mm pivot lugs 25 mm tall with 8.5 mm pin holes at one end
let length = 250.0; // [180.0, 320.0] Plate length (mm)
let width = 120.0; // [90.0, 160.0] Plate width (mm)
let slots = 9; // [4, 14] Number of drain slots
let pin_d = 8.5; // [6.0, 12.0] Pivot pin hole diameter (mm)
const t = 5.0;
const lug_t = 10.0;
const lug_h = 25.0;
let plate = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let plate = plate.fillet(8.0, plate.edges("|Z"));
let parts = [plate];
for y in [-width / 4.0, 0.0, width / 4.0] {
    parts.push(box_centered(length - 40.0, 4.0, 8.5).translate([0, y, -3.75]));
}
for s in [-1.0, 1.0] {
    let lug = box_from_corners([-length / 2.0, s * (width / 2.0 - 15.0) - lug_t / 2.0, t - 0.5], [-length / 2.0 + 30.0, s * (width / 2.0 - 15.0) + lug_t / 2.0, t + lug_h]);
    parts.push(lug.fillet(8.0, lug.edges("|Y and >Z and <X")));
}
let body = fuse_all(parts);
let sp = (length - 80.0) / slots.to_float();
let sw = min(8.0, sp * 0.6);
let sl = width * 0.75;
let cuts = [cylinder([-length / 2.0 + 12.0, -width, t + lug_h - 9.0], "Y", pin_d / 2.0, 2.0 * width)];
for i in 0..slots {
    let x = -length / 2.0 + 45.0 + sp * (i.to_float() + 0.5);
    cuts.push(box_centered(sw, sl, t + 2.0).translate([x, 0, t / 2.0]));
}
body - fuse_all(cuts)
