// 90 degree spark plug boot: 20 mm grip 45 mm tall with 10 mm bore 38 mm deep over the insulator, 18 mm cable leg 35 mm with 7.2 mm lead bore, flared skirt, 3 grip rings
let boot_d = 20.0; // [16.0, 26.0] Boot diameter (mm)
let boot_height = 45.0; // [30.0, 70.0] Boot height (mm)
let bore_d = 10.0; // [8.0, 14.0] Insulator bore (mm)
let bore_depth = 38.0; // [20.0, 55.0] Insulator bore depth (mm)
let lead_d = 7.2; // [5.0, 9.0] Ignition lead bore (mm)
let leg_length = 35.0; // [20.0, 60.0] Cable leg length (mm)
let rings = 3; // [0, 6] Number of grip rings
let r = boot_d / 2.0;
let bd = min(bore_depth, boot_height - lead_d / 2.0 - 3.0);
let parts = [
    cylinder([0, 0, 0], "Z", r, boot_height),
    sphere([0, 0, boot_height], r + 0.3),
    cylinder([0, 0, boot_height], "X", r - 1.0, leg_length),
    cone(r + 1.5, r, 6.0)
];
for i in 0..rings { parts.push(cylinder([0, 0, 12.0 + i.to_float() * 6.0], "Z", r + 0.6, 2.0)); }
let boot = fuse_all(parts);
boot = boot - cylinder([0, 0, -1.0], "Z", bore_d / 2.0, bd + 1.0) - cone(bore_d / 2.0 + 1.5, bore_d / 2.0, 3.0).translate([0, 0, -0.01]);
boot - cylinder([0, 0, boot_height], "X", lead_d / 2.0, leg_length + 1.0) - cylinder([0, 0, bd - 1.0], "Z", 1.8, boot_height - bd + 1.0)
