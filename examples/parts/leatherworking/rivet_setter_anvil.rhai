// Double-cap rivet setting anvil: 40 mm disc 12 mm thick with 4 domed cups 6, 8, 10 and 12 mm, non-slip base ring
let d = 40.0; // [30.0, 60.0] Anvil diameter (mm)
let t = 12.0; // [8.0, 20.0] Thickness (mm)
let a = cylinder(d / 2.0, t);
let cups = [];
let sizes = [6.0, 8.0, 10.0, 12.0];
for i in 0..4 { let ang = (i.to_float() * 90.0 + 45.0) * PI() / 180.0; cups.push(sphere([d * 0.25 * ang.cos(), d * 0.25 * ang.sin(), t + sizes[i] * 0.3], sizes[i] / 2.0)); }
a - compound(cups) - (cylinder([0, 0, -1], "Z", d / 2.0 - 3.0, 1.5) - cylinder([0, 0, -2], "Z", d / 2.0 - 6.0, 4.0))
