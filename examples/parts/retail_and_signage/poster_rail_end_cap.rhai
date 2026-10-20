// Snap poster hanger rail end cap: fits a 30 x 12 mm aluminium profile, 2 mm cap, 8 mm plug, hang loop 10 mm
let w = 30.0; // [20.0, 40.0] Profile width (mm)
let h = 12.0; // [8.0, 20.0] Profile height (mm)
let cap = box_centered(w + 2.0, h + 2.0, 2.0).translate([0, 0, 1.0]);
let c = cap.fillet(2.0, cap.edges("|Z"));
let plug = box_centered(w - 3.0, h - 3.0, 8.0).translate([0, 0, -3.99]) - box_centered(w - 6.0, h - 6.0, 9.0).translate([0, 0, -4.5]);
let loop_ = cylinder([0, -2.0, 7.0], "Y", 6.0, 4.0) - cylinder([0, -3.0, 7.5], "Y", 3.5, 6.0) - box_centered(20, 10, 6).translate([0, 0, 2.0 - 3.0]);
c + plug + (loop_ & box_from_corners([-10, -5, 1.99], [10, 5, 20]))
