// Sash window pulley face plate: 125 x 32 mm plate 3 mm with a 95 x 22 mm wheel window and 2 countersunk holes
let length = 125.0; // [100.0, 150.0] Plate length (mm)
let width = 32.0; // [25.0, 40.0] Plate width (mm)
let t = 3.0; // [2.0, 4.0] Plate thickness (mm)
let p = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let pp = p.fillet(width / 2.0 - 0.5, p.edges("|Z"));
let win = box_centered(length - 30.0, width - 10.0, t * 3.0);
let w = win.fillet(width / 2.0 - 5.1, win.edges("|Z"));
pp - w - cylinder([-length / 2.0 + 7.5, 0, -1], "Z", 2.0, t + 2.0) - cylinder([length / 2.0 - 7.5, 0, -1], "Z", 2.0, t + 2.0)
