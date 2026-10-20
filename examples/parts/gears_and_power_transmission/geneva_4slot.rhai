// Geneva drive: 4-slot wheel (60 mm, 6 mm slots) and its drive crank with a 6 mm pin and locking disk, 5 mm thick
let wheel_d = 60.0; // [30.0, 150.0] Wheel diameter (mm)
let slots = 4; // [3, 8] Slots
let pin_d = 6.0; // [3.0, 12.0] Pin diameter (mm)
let thickness = 5.0; // [3.0, 12.0] Thickness (mm)
let r = wheel_d / 2.0;
let centers = r / (PI() / slots.to_float()).cos();
let crank_r = centers * (PI() / slots.to_float()).sin();
let wheel = cylinder(r, thickness);
for i in 0..slots {
    let a = i.to_float() * 360.0 / slots.to_float();
    wheel -= box_from_corners([r - (r + crank_r - centers) - 0.5, -pin_d / 2.0 - 0.2, -1], [r + 1.0, pin_d / 2.0 + 0.2, thickness + 1]).rotate_z(a);
    // the locking disk (radius 0.7 of the crank) seats in a concave arc between the slots
    wheel -= cylinder([centers, 0, -1], "Z", crank_r * 0.72, thickness + 2.0).rotate_z(a + 180.0 / slots.to_float());
}
wheel = wheel - cylinder([0, 0, -1], "Z", 4.0, thickness + 2.0);
let lock = cylinder([centers, 0, 0], "Z", crank_r * 0.7, thickness) - cylinder([centers - crank_r, 0, -1], "Z", crank_r * 0.75, thickness + 2.0);
let crank = box_from_corners([centers - crank_r, -4.0, thickness], [centers + 4.0, 4.0, thickness + 3.0]) + cylinder([centers - crank_r, 0, 0], "Z", pin_d / 2.0, thickness + 3.0);
[wheel, lock + crank]
