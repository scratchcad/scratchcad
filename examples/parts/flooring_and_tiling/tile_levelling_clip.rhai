// Tile levelling clip: 1.5 mm joint, 50 x 22 mm base plate 1.2 mm thick, 1.5 mm stem 35 mm tall with a 2 mm break-off notch 1 mm above the base and a 12 x 8 mm wedge window
let joint = 1.5; // [1.0, 3.0] Grout joint width (mm)
let tile_t = 10.0; // [6.0, 15.0] Max tile thickness (mm)
const base_t = 1.2;
let base = box_from_corners([-25.0, -11.0, 0], [25.0, 11.0, base_t]);
let stem = box_from_corners([-joint / 2.0, -9.0, base_t - 0.01], [joint / 2.0, 9.0, base_t + tile_t + 25.0]);
let window = box_from_corners([-joint, -6.0, base_t + tile_t], [joint, 6.0, base_t + tile_t + 8.0]);
let notch = box_from_corners([-joint, -9.5, base_t + 1.0], [joint, -8.0, base_t + 1.6]) + box_from_corners([-joint, 8.0, base_t + 1.0], [joint, 9.5, base_t + 1.6]);
base + stem - window - notch
