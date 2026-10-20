// TPU mount for a 19 mm micro FPV camera: 2 mm base with two M3 holes, two 2 mm side cheeks with M2 pivot holes and three tilt stops
let cam = 19.0; // [14.0, 22.0] Camera width (mm)
let h = 20.0; // [16.0, 26.0] Cheek height (mm)
let w = cam / 2.0;
let mount = box_from_corners([-w - 2.0, -8.0, 0], [w + 2.0, 8.0, 2.0]);
for s in [-1.0, 1.0] { mount += box_from_corners([s * w, -8.0, 0], [s * (w + 2.0), 8.0, h]); }
for y in [-4.5, 4.5] { mount -= cylinder([0, y, -1], "Z", 1.6, 4.0); }
mount -= cylinder([-w - 3.0, 0, h - 6.0], "X", 1.1, cam + 6.0);
for k in 0..3 {
    let a = (200.0 + k.to_float() * 20.0) * PI() / 180.0;
    mount -= cylinder([-w - 3.0, 4.5 * a.cos(), h - 6.0 + 4.5 * a.sin()], "X", 0.6, cam + 6.0);
}
mount
