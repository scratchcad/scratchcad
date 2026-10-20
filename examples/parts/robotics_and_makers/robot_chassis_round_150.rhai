// Round two-wheel robot chassis plate: 150 mm diameter, 3 mm, two 28 x 68 mm wheel cut-outs for 65 mm wheels, TT motor mounting holes, front and rear ball-caster holes, 20 mm wire pass holes
let dia = 150.0; // [100.0, 250.0] Plate diameter (mm)
let t = 3.0; // [2.0, 6.0] Plate thickness (mm)
let wheel_w = 28.0; // [15.0, 40.0] Wheel slot width (mm)
let wheel_len = 68.0; // [40.0, 100.0] Wheel slot length (mm)
let r = dia / 2.0;
let p = cylinder(r, t);
let ww = min(wheel_w, r * 0.4);
for s in [-1.0, 1.0] {
    p -= box_centered(ww, wheel_len, 10.0).translate([s * (r - ww / 2.0 + 2.0), 0, 0]);
    for y in [-8.75, 8.75] { p -= cylinder([s * (r - ww - 14.0), y, -1], "Z", 1.6, t + 2.0); }
    p -= box_centered(3.0, 6.0, 10.0).translate([s * (r - ww - 25.0), 0, 0]);
    p -= cylinder([0, s * (r - 15.0), -1], "Z", 1.6, t + 2.0);
    for x in [-12.0, 12.0] { p -= cylinder([x, s * (r - 15.0), -1], "Z", 1.6, t + 2.0); }
    p -= cylinder([s * 20.0, 0, -1], "Z", 10.0, t + 2.0);
}
for i in 0..8 { p -= cylinder([r * 0.55, 0, -1], "Z", 1.6, t + 2.0).rotate_z(i.to_float() * 45.0 + 22.5); }
p.fillet(1.0, ">Z and %CIRCLE").translate([0, 0, 0])
