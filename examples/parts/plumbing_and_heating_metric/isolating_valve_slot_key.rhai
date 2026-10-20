// Isolating valve slot key for slotted 15/22 mm service valves: 5 x 0.9 mm blade 6 mm long on a 7 mm shank, 45 mm fluted grip 22 mm diameter, quarter-turn index flat, hanging hole
let blade_w = 5.0; // [3.0, 8.0] Blade width (mm)
let blade_t = 0.9; // [0.6, 1.6] Blade thickness (mm)
let blade_len = 6.0; // [3.0, 10.0] Blade length (mm)
let shank = 18.0; // [8.0, 40.0] Shank length (mm)
let grip_d = 22.0; // [16.0, 30.0] Grip diameter (mm)
let grip_len = 45.0; // [30.0, 70.0] Grip length (mm)
let flutes = 8; // [4, 12] Number of grip flutes
let rg = grip_d / 2.0;
let grip = cylinder([0, 0, blade_len + shank], "Z", rg, grip_len);
let grip = grip.chamfer(1.5, grip.edges());
let cuts = [];
for k in 0..flutes {
    let a = (k.to_float() + 0.5) * 360.0 / flutes.to_float();
    cuts.push(cylinder([rg + 0.8, 0, blade_len + shank + 6.0], "Z", 2.2, grip_len - 12.0).rotate_z(a));
}
cuts.push(box_from_corners([-rg - 1.0, rg - 1.5, blade_len + shank + grip_len - 12.0], [rg + 1.0, rg + 1.0, blade_len + shank + grip_len + 1.0]));
cuts.push(cylinder([-rg - 1.0, 0, blade_len + shank + grip_len - 6.0], "X", 2.5, grip_d + 2.0));
let shank_s = cylinder([0, 0, blade_len - 0.5], "Z", 3.5, shank + 1.0);
let blade = box_centered(min(blade_w, 7.0), blade_t, blade_len + 1.0).translate([0, 0, (blade_len + 1.0) / 2.0]);
(grip - fuse_all(cuts)) + shank_s + blade
