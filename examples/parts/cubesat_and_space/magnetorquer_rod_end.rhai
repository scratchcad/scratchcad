// Magnetorquer rod end cap: 10 mm core socket 6 mm deep, 14 mm flange with 2 M2 tabs 20 mm apart, wire exit 1.5 mm
let core = 10.0; // [6.0, 14.0] Rod core diameter (mm)
let flange = 14.0; // [10.0, 20.0] Flange diameter (mm)
let cap = cylinder(flange / 2.0, 8.0) - cylinder([0, 0, 2.0], "Z", core / 2.0 + 0.1, 7.0);
let tabs = box_centered(26.0, 6.0, 2.0).translate([0, 0, 1.0]);
let t = tabs.fillet(2.9, tabs.edges("|Z"));
cap + t - cylinder([-10.0, 0, -1], "Z", 1.1, 4.0) - cylinder([10.0, 0, -1], "Z", 1.1, 4.0) - cylinder([0, -flange, 5.0], "Y", 0.75, flange)
