// Bar magnet holder for classroom demos: cradle for a 75 x 12 x 6 mm magnet, 90 x 30 mm base, N/S letter recesses
let ml = 75.0; // [50.0, 100.0] Magnet length (mm)
let mw = 12.0; // [8.0, 20.0] Magnet width (mm)
let mt = 6.0; // [4.0, 10.0] Magnet thickness (mm)
let base = box_centered(ml + 15.0, mw + 18.0, mt + 4.0).translate([0, 0, (mt + 4.0) / 2.0]);
let b = base.fillet(4.0, base.edges("|Z"));
let pocket = box_centered(ml + 0.6, mw + 0.6, mt + 1.0).translate([0, 0, 4.0 + (mt + 1.0) / 2.0]);
let finger = cylinder([0, -mw, 4.0 + mt], "Y", 6.0, mw * 2.0);
let n_ = box_centered(1.5, 6.0, 2.0).translate([-ml / 2.0 - 4.0, -mw / 2.0 - 3.0, mt + 4.0]);
b - pocket - finger - n_
