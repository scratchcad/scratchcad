// GoPro-style 3-finger mount
let finger_t = 3.0; // [2.8, 3.2] Finger thickness (mm)
let gap = 3.1; // [3.0, 3.5] Gap between fingers (mm)
let finger_d = 15.0; // [12.0, 16.0] Finger end diameter (mm)
let hole_d = 5.1; // [4.8, 5.5] Thumbscrew hole (mm)
let base_l = 30.0; let base_w = 20.0; let base_t = 4.0;
let axis_h = base_t + 9.0;
let fingers = [];
let total = 3.0 * finger_t + 2.0 * gap;
for i in 0..3 {
    let y = -total / 2.0 + i.to_float() * (finger_t + gap);
    let disc = cylinder([0, y, axis_h], "Y", finger_d / 2.0, finger_t);
    let web = box_from_corners([-finger_d / 2.0, y, base_t - 0.1], [finger_d / 2.0, y + finger_t, axis_h]);
    fingers.push(disc + web);
}
let base = box_centered(base_l, base_w, base_t).translate([0, 0, base_t / 2.0]).fillet(2.0, "|Z");
let part = fuse_all([base] + fingers);
part - cylinder([0, -total, axis_h], "Y", hole_d / 2.0, 2.0 * total)
