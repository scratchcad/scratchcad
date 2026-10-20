// C-fold paper towel dispenser stack pusher plate: 250 x 90 mm plate 3 mm thick with 5 mm corner radii, two 4 x 6 mm stiffening ribs along its length underneath, a 40 x 20 mm finger pull window, and an 8 mm guide peg 10 mm long at each end that runs in the cabinet slots
let length = 250.0; // [150.0, 300.0] Plate length (mm)
let width = 90.0; // [60.0, 120.0] Plate width (mm)
let peg_len = 10.0; // [5.0, 20.0] Guide peg length (mm)
const t = 3.0;
const peg_d = 8.0;
let plate = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let plate = plate.fillet(5.0, plate.edges("|Z"));
let parts = [plate];
for y in [-width / 4.0, width / 4.0] {
    parts.push(box_centered(length - 20.0, 4.0, 6.5).translate([0, y, -2.75]));
}
for a in [0.0, 180.0] {
    parts.push(cylinder([length / 2.0 - 0.5, 0, t / 2.0], "X", peg_d / 2.0, peg_len + 0.5).rotate_z(a));
}
let body = fuse_all(parts);
let ww = min(40.0, length * 0.3);
body - box_centered(ww, 20.0, 20.0)
