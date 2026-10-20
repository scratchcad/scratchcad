// Door transfer grille 300 x 75 mm: 3 mm face frame with 12 mm border, 280 x 55 mm collar 30 mm deep with 2 mm wall for the door cut-out, 4 sight-proof slats 2 mm thick at 45 degrees
let length = 300.0; // [200.0, 500.0] Face length (mm)
let height = 75.0; // [60.0, 150.0] Face height (mm)
let collar_depth = 30.0; // [20.0, 45.0] Collar depth (mm)
let slat_count = 4; // [2, 8] Number of slats
const border = 10.0;
const face_t = 3.0;
const wall = 2.0;
let cl = length - 2.0 * border;
let ch = height - 2.0 * border;
let face = box_centered(length, height, face_t).translate([0, 0, face_t / 2.0]);
face = face.fillet(3.0, "|Z");
face = face.chamfer(1.0, ">Z");
let collar = box_centered(cl, ch, collar_depth).translate([0, 0, -collar_depth / 2.0 + 0.5]);
let grille = (face + collar) - box_centered(cl - 2.0 * wall, ch - 2.0 * wall, collar_depth + face_t + 4.0).translate([0, 0, face_t / 2.0 - collar_depth / 2.0]);
let pitch = (ch - 2.0 * wall) / slat_count.to_float();
let sw = min(pitch * 1.4, collar_depth * 1.1);
let slats = [];
for i in 0..slat_count {
    let y = -(ch - 2.0 * wall) / 2.0 + pitch * (i.to_float() + 0.5);
    slats.push(box_centered(cl - wall, 2.0, sw).rotate_x(45.0).translate([0, y, -collar_depth / 2.0 + 1.0]));
}
fuse_all([grille] + slats)
