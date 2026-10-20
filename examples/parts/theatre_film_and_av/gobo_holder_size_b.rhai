// Gobo holder size B: 86 mm gobo (64 mm image) holder plate 2 mm, 87 mm seat recessed 0.8 mm, 64 mm aperture, three spring tabs, 120 x 95 mm plate with a 25 mm handle
let gobo = 86.0; // [80.0, 90.0] Gobo diameter (mm)
let image = 64.0; // [55.0, 70.0] Image diameter (mm)
let thickness = 2.0; // [1.5, 3.0] Plate thickness (mm)
let plate_width = 95.0; // [92.0, 110.0] Plate width (mm)
let plate = box_from_corners([-plate_width / 2.0, -plate_width / 2.0, 0], [plate_width / 2.0, plate_width / 2.0 + 25.0, thickness]);
let p = plate.fillet(6.0, plate.edges("|Z"));
let seat = cylinder([0, 0, thickness - 0.8], "Z", (gobo + 1.0) / 2.0, 1.0);
let hole = cylinder([0, 0, -1.0], "Z", image / 2.0, thickness + 2.0);
let grip = box_from_corners([-15.0, plate_width / 2.0 + 8.0, -1.0], [15.0, plate_width / 2.0 + 16.0, thickness + 1.0]);
let tabs = [];
for k in 0..3 {
    tabs.push(box_from_corners([gobo / 2.0 - 3.0, -4.0, thickness - 0.01], [gobo / 2.0 + 3.0, 4.0, thickness + 1.5]).rotate_z(30.0 + k.to_float() * 120.0));
}
p - seat - hole - grip.fillet(3.9, grip.edges("|Z")) + fuse_all(tabs)
