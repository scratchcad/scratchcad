// Flexible duct clamp band for 100 mm flex duct: 9 mm wide band 1.2 mm thick closing to 102 mm, worm-drive housing 16 x 8 mm with a 5.5 mm screw channel, 8 slots for the worm in the band
let duct_d = 102.0; // [60.0, 200.0] Clamp inside diameter (mm)
let band_w = 9.0; // [8.0, 14.0] Band width (mm)
let t = 1.2; // [0.8, 2.0] Band thickness (mm)
let slot_count = 8; // [4, 16] Number of worm slots
const housing_l = 16.0;
const housing_h = 8.0;
let r = duct_d / 2.0;
let band = cylinder(r + t, band_w) - cylinder([0, 0, -1], "Z", r, band_w + 2.0);
let housing = box_from_corners([-housing_l / 2.0, r + t - 0.5, -1.0], [housing_l / 2.0, r + t + housing_h, band_w + 1.0]);
housing = housing.fillet(1.5, housing.edges("|X and >Y"));
let screw = cylinder([-housing_l, r + t + housing_h / 2.0, band_w / 2.0], "X", 2.75, 2.0 * housing_l);
let slots = [];
for k in 0..slot_count {
    let a = 25.0 + k.to_float() * 6.0;
    slots.push(box_centered(1.2, 4.0 * t, band_w * 0.5).translate([0, r + t / 2.0, band_w / 2.0]).rotate_z(a));
}
band + housing - screw - compound(slots)
