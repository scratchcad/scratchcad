// Cat flap tunnel frame: 190 x 200 mm outer, 140 x 150 mm opening, 10 mm flange 3 mm, 45 mm tunnel for doors up to 40 mm
let w = 140.0; // [120.0, 180.0] Opening width (mm)
let h = 150.0; // [120.0, 200.0] Opening height (mm)
let tunnel = 45.0; // [30.0, 70.0] Tunnel depth (mm)
let wall = 3.0; // [2.0, 4.0] Wall (mm)
let flange = box_centered(w + 50.0, h + 50.0, wall).translate([0, 0, wall / 2.0]);
let f = flange.fillet(15.0, flange.edges("|Z"));
let tun = box_centered(w + 2.0 * wall, h + 2.0 * wall, tunnel).translate([0, 0, tunnel / 2.0]);
let t = tun.fillet(12.0, tun.edges("|Z"));
let hole = box_centered(w, h, tunnel * 3.0);
let hh = hole.fillet(10.0, hole.edges("|Z"));
let hinge = cylinder([-w / 2.0, h / 2.0 - 3.0, tunnel - 6.0], "X", 3.0, w);
f + t - hh + (hinge & box_centered(w + 2.0 * wall, h + 2.0 * wall, tunnel * 3.0))
