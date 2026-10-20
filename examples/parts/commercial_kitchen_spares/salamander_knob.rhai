// Salamander grill control knob: 40 mm skirt, 34 mm fluted grip 22 mm tall with 12 flutes, pointer ridge, 6 mm D-shaft bore (4.6 mm across the flat) 15 mm deep
let grip_d = 34.0; // [26.0, 40.0] Grip diameter (mm)
let height = 22.0; // [16.0, 30.0] Knob height (mm)
let flutes = 12; // [6, 18] Number of flutes
let shaft = 6.0; // [4.0, 8.0] Shaft diameter (mm)
const skirt_t = 4.0;
let skirt_d = grip_d + 6.0;
let grip = cylinder([0, 0, 0], "Z", grip_d / 2.0, height);
grip = grip.chamfer(2.0, grip.edges(">Z"));
let knob = cylinder([0, 0, 0], "Z", skirt_d / 2.0, skirt_t) + grip;
let cuts = [];
for i in 0..flutes {
    let a = i.to_float() * 360.0 / flutes.to_float() + 180.0 / flutes.to_float();
    cuts.push(cylinder([grip_d / 2.0 + 0.6, 0, skirt_t + 2.0], "Z", 2.0, height).rotate_z(a));
}
knob = knob - compound(cuts);
knob = knob + box_from_corners([0, -1.5, height - 0.01], [grip_d / 2.0 - 3.0, 1.5, height + 1.5]);
let r = shaft / 2.0 + 0.05;
let d_bore = cylinder([0, 0, -1.0], "Z", r, 16.0) - box_from_corners([shaft * 0.77 - shaft / 2.0, -shaft, -2.0], [shaft, shaft, 20.0]);
knob - d_bore
