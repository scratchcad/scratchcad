// Darning plate that covers the feed dogs: 40 x 26 x 1.5 mm plate with 4 mm rounded corners, 6 x 2 mm needle slot, two spring clip legs 1.5 mm thick and 5 mm deep under the ends
let length = 40.0; // [30.0, 60.0] Plate length (mm)
let width = 26.0; // [18.0, 36.0] Plate width (mm)
let leg_span = 30.0; // [20.0, 50.0] Leg spacing (mm)
let slot_l = 6.0; // [4.0, 8.0] Needle slot length (mm)
const t = 1.5;
const leg_h = 5.0;
let plate = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let plate = plate.fillet(4.0, plate.edges("|Z"));
let span = min(leg_span, length - 6.0);
let legs = [];
for s in [-1.0, 1.0] {
    legs.push(box_from_corners([s * span / 2.0 - 0.75, -width / 4.0, -leg_h], [s * span / 2.0 + 0.75, width / 4.0, 0.5]));
}
(plate + fuse_all(legs)) - box_centered(slot_l, 2.0, 4.0 * t)
