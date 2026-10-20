// Spring band hose clamp for 20 mm hose: 20 mm relaxed ID, 12 mm wide 1 mm spring steel band, two 9 mm squeeze ears 16 degrees apart
let inner_d = 20.0; // [10.0, 50.0] Relaxed inner diameter (mm)
let band_width = 12.0; // [6.0, 18.0] Band width (mm)
let band = 1.0; // [0.6, 1.6] Band thickness (mm)
let ear_length = 9.0; // [5.0, 14.0] Ear length (mm)
let ear_angle = 16.0; // [10.0, 30.0] Angle between the ears (degrees)
let r = inner_d / 2.0;
let ring = cylinder(r + band, band_width) - cylinder([0, 0, -1.0], "Z", r, band_width + 2.0);
ring = ring - box_from_corners([0, -0.5, -1.0], [r + band + 1.0, 0.5, band_width + 1.0]);
let ear = box_from_corners([r + band * 0.5, 0.5, 1.5], [r + band + ear_length, 0.5 + band, band_width - 1.5]);
let ear_a = ear.rotate_z(ear_angle / 2.0 - 3.0);
let ear_b = ear.mirror("ZX").rotate_z(-(ear_angle / 2.0 - 3.0));
fuse_all([ring, ear_a, ear_b])
