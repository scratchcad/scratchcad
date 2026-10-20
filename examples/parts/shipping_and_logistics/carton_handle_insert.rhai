// Carton hand-hole insert: 95 x 30 mm D-handle grip ring 3 mm, snaps into a 90 x 25 mm cut-out in 5 mm board
let w = 90.0; // [70.0, 120.0] Cut-out width (mm)
let h = 25.0; // [20.0, 40.0] Cut-out height (mm)
let board = 5.0; // [3.0, 8.0] Board thickness (mm)
let flange = box_centered(w + 10.0, h + 10.0, 2.0).translate([0, 0, 1.0]);
let f = flange.fillet(h / 2.0 + 4.9, flange.edges("|Z"));
let sleeve = box_centered(w - 0.4, h - 0.4, board + 2.0).translate([0, 0, -(board + 2.0) / 2.0 + 0.01]);
let s = sleeve.fillet(h / 2.0 - 0.3, sleeve.edges("|Z"));
let hole = box_centered(w - 6.0, h - 6.0, 30.0);
let hh = hole.fillet(h / 2.0 - 3.1, hole.edges("|Z"));
let lip = box_centered(w + 1.0, h + 1.0, 1.0).translate([0, 0, -board - 0.5]);
let l = lip.fillet(h / 2.0 + 0.4, lip.edges("|Z"));
f + s + l - hh
