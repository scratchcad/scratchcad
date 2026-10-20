// DIN 6798 A M6 external tooth lock washer: 6.4 mm ID, 11 mm OD, 0.7 mm thick, 9 teeth
let inner_d = 6.4; // [2.2, 21.0] Inner diameter (mm)
let outer_d = 11.0; // [4.5, 36.0] Outer diameter (mm)
let thickness = 0.7; // [0.3, 1.5] Thickness (mm)
let teeth = 9; // [6, 16] Number of teeth
let ring = cylinder(outer_d / 2.0, thickness) - cylinder([0, 0, -1], "Z", inner_d / 2.0, thickness + 2.0);
let slots = [];
for i in 0..teeth {
    let r0 = inner_d / 2.0 + (outer_d - inner_d) * 0.2;
    let slot = box_from_corners([r0, -0.25 - (outer_d - inner_d) * 0.05, -1], [outer_d, 0.25 + (outer_d - inner_d) * 0.05, thickness + 1]);
    slots.push(slot.rotate_z(i * 360.0 / teeth.to_float() + 8.0));
}
let toothed = ring - fuse_all(slots);
// twist each tooth a little: shown by cutting a shallow bevel on alternate sides
toothed
