// Dive belt weight keeper: fits 50 mm webbing, 60 x 20 x 6 mm slide with a 51 x 4 mm slot and a locking tooth row
let webbing = 50.0; // [38.0, 55.0] Belt width (mm)
let t = 6.0; // [4.0, 8.0] Thickness (mm)
let k = box_centered(webbing + 10.0, 20.0, t).translate([0, 0, t / 2.0]);
let kk = k.fillet(4.0, k.edges("|Z"));
let slot = box_centered(webbing + 1.0, 4.0, t + 2.0).translate([0, 0, t / 2.0]);
let teeth = [];
for i in 0..12 { teeth.push(box_centered(1.2, 1.5, t - 1.0).translate([-webbing / 2.0 + 3.0 + i.to_float() * 4.0, -2.0 - 0.74, t / 2.0])); }
kk - slot + compound(teeth)
