// Ski carry strap buckle: 40 x 30 mm frame 4 mm thick for a 25 mm strap, with two 8 mm strap slots either side of a 6 mm centre bar
let strap = 25.0; // [20.0, 40.0] Strap width (mm)
let t = 4.0; // [3.0, 6.0] Buckle thickness (mm)
let w = strap + 8.0;
let f = box_centered(w, 30.0, t).translate([0, 0, t / 2.0]);
let f = f.fillet(4.0, f.edges("|Z"));
f - box_centered(strap + 1.0, 8.0, t + 2.0).translate([0, 7.0, t / 2.0]) - box_centered(strap + 1.0, 8.0, t + 2.0).translate([0, -7.0, t / 2.0])
