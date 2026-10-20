// 1/2 in BSP tap jumper (washer plate): 12.5 mm plate 1.5 mm, 4.8 mm stem 14 mm into the headgear, 3 mm washer post with a 6 mm button nut
let plate_d = 12.5; // [10.0, 16.0] Plate diameter (mm)
let plate_t = 1.5; // [1.0, 2.5] Plate thickness (mm)
let stem_d = 4.8; // [3.5, 6.0] Stem diameter (mm)
let stem_l = 14.0; // [8.0, 20.0] Stem length (mm)
let washer_t = 3.0; // [2.0, 4.0] Washer thickness (mm)
let plate = cylinder(plate_d / 2.0, plate_t);
let stem = cylinder([0, 0, plate_t - 0.5], "Z", stem_d / 2.0, stem_l + 0.5);
let s = stem.chamfer(0.4, stem.edges(">Z"));
let post = cylinder([0, 0, -washer_t], "Z", 1.5, washer_t + 0.5);
let button = cylinder([0, 0, -washer_t - 1.0], "Z", 3.0, 1.0);
plate + s + post + button
