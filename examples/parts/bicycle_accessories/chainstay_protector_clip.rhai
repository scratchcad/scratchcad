// Chainstay protector strip: 120 mm long, 25 mm wide curved pad 3 mm for a 22 mm stay, 3 strap slots 12 x 3 mm
let length = 120.0; // [80.0, 180.0] Length (mm)
let stay = 22.0; // [16.0, 30.0] Chainstay diameter (mm)
let t = 3.0; // [2.0, 5.0] Pad thickness (mm)
let r = stay / 2.0;
let pad = (cylinder([0, 0, 0], "X", r + t, length) - cylinder([-1, 0, 0], "X", r, length + 2.0)) & box_from_corners([-1, -r - t - 1.0, 0], [length + 1.0, r + t + 1.0, r + t + 1.0]);
let slots = [];
for k in 0..3 { slots.push(box_centered(12.0, (r + t) * 3.0, 3.0).translate([20.0 + k.to_float() * 40.0, 0, r * 0.5]).rotate([20.0 + k.to_float() * 40.0, 0, 0], "X", 90.0)); }
pad - fuse_all(slots)
