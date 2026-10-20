// HDMI cable lock clamp for a camera cage: 50 x 14 x 6 mm base with a 1/4-20 clearance slot (6.5 x 12 mm), raised jaw block holding a 7.5 mm cable in a half-round seat, 16 x 7 mm HDMI plug pocket 12 mm deep in front, and an M3 screw hole (3.2 mm) for the clamp cap
let cable_d = 7.5; // [4.0, 10.0] Cable diameter (mm)
let base_len = 50.0; // [40.0, 80.0] Base length (mm)
let plug_w = 16.0; // [12.0, 22.0] Plug body width (mm)
const base_w = 14.0;
const base_t = 6.0;
let jaw_w = max(plug_w + 6.0, cable_d + 10.0);
let jaw_h = cable_d / 2.0 + 6.0;
let base = box_from_corners([0, -base_w / 2.0, 0], [base_len, base_w / 2.0, base_t]);
let base = base.fillet(3.0, base.edges("|Z and <X"));
let jaw = box_from_corners([base_len - 20.0, -jaw_w / 2.0, 0], [base_len, jaw_w / 2.0, base_t + jaw_h]);
let jaw = jaw.fillet(1.5, jaw.edges("|Z"));
let zc = base_t + jaw_h;
let seat = cylinder([base_len - 21.0, 0, zc], "X", cable_d / 2.0 + 0.2, 10.0);
let pocket = box_from_corners([base_len - 12.0, -plug_w / 2.0, zc - 3.5], [base_len + 1.0, plug_w / 2.0, zc + 1.0]);
let slot = box_centered(12.0 - 6.5, 6.5, base_t + 2.0).translate([15.0, 0, base_t / 2.0])
    + cylinder([15.0 - (12.0 - 6.5) / 2.0, 0, -1.0], "Z", 3.25, base_t + 2.0) + cylinder([15.0 + (12.0 - 6.5) / 2.0, 0, -1.0], "Z", 3.25, base_t + 2.0);
let screws = cylinder([base_len - 16.0, jaw_w / 2.0 - 2.5, base_t], "Z", 1.6, jaw_h + 1.0) + cylinder([base_len - 16.0, -jaw_w / 2.0 + 2.5, base_t], "Z", 1.6, jaw_h + 1.0);
base + jaw - seat - pocket - slot - screws
