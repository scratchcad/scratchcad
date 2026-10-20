// Washroom dispenser key, flat type: 4 mm thick key with a 30 mm round bow and 12 mm finger hole, and a 3 mm thick blade 6 mm wide and 22 mm long with a 3 mm deep notch 8 mm from the tip that trips the dispenser catch
let blade_len = 22.0; // [12.0, 40.0] Blade length (mm)
let blade_w = 6.0; // [4.0, 10.0] Blade width (mm)
let blade_t = 3.0; // [1.5, 4.0] Blade thickness (mm)
let bow_d = 30.0; // [22.0, 45.0] Bow diameter (mm)
const bow_t = 4.0;
let rb = bow_d / 2.0;
let bow = cylinder([0, 0, 0], "Z", rb, bow_t) - cylinder([0, -rb * 0.25, -1.0], "Z", min(6.0, rb - 6.0), bow_t + 2.0);
let neck = box_from_corners([-blade_w / 2.0 - 2.0, rb - 3.0, 0], [blade_w / 2.0 + 2.0, rb + 4.0, bow_t]);
let z0 = (bow_t - blade_t) / 2.0;
let blade = box_from_corners([-blade_w / 2.0, rb + 3.0, z0], [blade_w / 2.0, rb + 4.0 + blade_len, z0 + blade_t]);
let nd = min(3.0, blade_w - 2.0);
let ny = rb + 4.0 + blade_len - min(8.0, blade_len - 4.0);
let notch = box_from_corners([blade_w / 2.0 - nd, ny - 1.5, -1.0], [blade_w / 2.0 + 1.0, ny + 1.5, bow_t + 1.0]);
let key = fuse_all([bow, neck, blade]) - notch;
key.chamfer(0.5, key.edges("|Z and >Y"))
