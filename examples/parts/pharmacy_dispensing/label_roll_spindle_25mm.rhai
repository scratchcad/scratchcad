// Dispensing label printer roll spindle for 25.4 mm (1 inch) cores: 24.8 mm barrel 76 mm long for 72 mm wide label rolls, 3 core grip ribs 0.5 mm proud, a 60 mm guide flange 2.5 mm thick at one end, and 8 mm axle stubs 10 mm long at both ends
let core_d = 25.4; // [19.0, 40.0] Roll core diameter (mm)
let roll_w = 72.0; // [40.0, 110.0] Label roll width (mm)
let flange_d = 60.0; // [40.0, 100.0] Flange diameter (mm)
let axle_d = 8.0; // [5.0, 12.0] Axle stub diameter (mm)
const flange_t = 2.5;
const stub_len = 10.0;
const rib_proud = 0.5;
let rb = core_d / 2.0 - 0.3;
let blen = roll_w + 4.0;
let rf = max(flange_d / 2.0, rb + 5.0);
let ax = min(axle_d / 2.0, rb - 3.0);
let parts = [
    cylinder([0, 0, -stub_len], "Z", ax, stub_len + 0.5),
    cylinder([0, 0, 0], "Z", rf, flange_t),
    cylinder([0, 0, flange_t - 0.5], "Z", rb, blen + 0.5),
    cylinder([0, 0, flange_t + blen - 0.5], "Z", ax, stub_len + 0.5),
];
for i in 0..3 {
    parts.push(box_from_corners([rb - 0.5, -1.0, flange_t + 5.0], [rb + rib_proud, 1.0, flange_t + blen - 5.0]).rotate_z(30.0 + i * 120.0));
}
fuse_all(parts)
