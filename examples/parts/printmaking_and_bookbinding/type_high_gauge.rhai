// Letterpress type-high gauge: 60 x 25 mm stepped block, type high 23.32 mm (0.918 inch), plate base 16.8 mm (for 1/16 inch plates on a 0.855 inch base) and a 21.7 mm furniture step
let type_high = 23.32; // [23.2, 23.4] Type height (mm)
let base_h = 21.72; // [21.0, 22.5] Plate base height (mm)
const length = 60.0;
const width = 25.0;
let a = box_from_corners([0, 0, 0], [length / 3.0 + 0.01, width, type_high]);
let b = box_from_corners([length / 3.0, 0, 0], [2.0 * length / 3.0 + 0.01, width, base_h]);
let c = box_from_corners([2.0 * length / 3.0, 0, 0], [length, width, 16.8]);
let g = a + b + c;
g - cylinder([length / 6.0, width / 2.0, type_high - 0.5], "Z", 2.0, 1.0)
