// Luggage trolley handle tube end cap: plug for a 22 x 12 mm rounded-rectangle tube with 1 mm wall, 15 mm plug with crush ribs and a flat 25 x 15 mm cap 4 mm thick
let tube_w = 22.0; // [18.0, 30.0] Tube outer width (mm)
let tube_h = 12.0; // [10.0, 18.0] Tube outer height (mm)
const wall = 1.0;
let cap = box_centered(tube_w + 3.0, tube_h + 3.0, 4.0).translate([0, 0, 2.0]);
let cap = cap.fillet(3.0, cap.edges("|Z"));
let plug = box_centered(tube_w - 2.0 * wall - 0.3, tube_h - 2.0 * wall - 0.3, 15.0).translate([0, 0, -7.5 + 0.01]);
let plug = plug.fillet(2.0, plug.edges("|Z"));
let ribs = box_centered(tube_w - 2.0 * wall + 0.4, 1.0, 10.0).translate([0, 0, -8.0]);
cap + plug + ribs
