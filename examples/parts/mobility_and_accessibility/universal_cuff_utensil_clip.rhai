// Universal cuff utensil clip: palm cuff holder for a 12 x 3 mm utensil shank, 80 mm wide open C-band for a 75 mm palm, 25 mm band 2.5 mm thick, utensil pocket 40 mm long on the palm side
// # Cuff
let palm = 75.0; // [60.0, 95.0] Palm width (mm)
let band_width = 25.0; // [18.0, 35.0] Band width (mm)
let band_t = 2.5; // [2.0, 4.0] Band thickness (mm)
let opening = 30.0; // [20.0, 45.0] Opening gap (mm)
// # Pocket
let shank_w = 12.0; // [6.0, 16.0] Utensil shank width (mm)
let shank_t = 3.0; // [2.0, 5.0] Utensil shank thickness (mm)
let r = palm / 2.0;
let band = cylinder([0, 0, 0], "Z", r + band_t, band_width) - cylinder([0, 0, -1.0], "Z", r, band_width + 2.0);
let gap = box_from_corners([-opening / 2.0, 0, -1.0], [opening / 2.0, r + band_t + 1.0, band_width + 1.0]);
let pocket = box_from_corners([-shank_w / 2.0 - 2.5, -r - band_t - shank_t - 4.0, 0], [shank_w / 2.0 + 2.5, -r - band_t + 0.5, band_width]);
let sleeve = box_from_corners([-shank_w / 2.0, -r - band_t - shank_t - 1.5, -1.0], [shank_w / 2.0, -r - band_t - 1.5, band_width + 1.0]);
let c = band - gap + pocket - sleeve;
c.fillet(0.8, "|Z and >Y")
