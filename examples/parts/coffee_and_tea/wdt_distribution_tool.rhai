// WDT espresso distribution tool handle: 25 mm round handle 40 mm tall, 8 needle holes 0.4 mm on a 14 mm circle, 10 mm deep
let d = 25.0; // [18.0, 35.0] Handle diameter (mm)
let height = 40.0; // [25.0, 60.0] Handle height (mm)
let needles = 8; // [4, 12] Number of needles
let needle = 0.4; // [0.25, 0.6] Needle diameter (mm)
let h = cylinder(d / 2.0, height);
let hh = h.fillet(4.0, h.edges(">Z")).chamfer(1.0, h.edges("<Z"));
let holes = [];
for k in 0..needles { let a = (k.to_float() * 360.0 / needles.to_float()) * PI() / 180.0; holes.push(cylinder([7.0 * a.cos(), 7.0 * a.sin(), -1], "Z", needle / 2.0 + 0.05, 11.0)); }
hh - compound(holes)
