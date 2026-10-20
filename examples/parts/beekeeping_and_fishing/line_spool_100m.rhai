// Fishing line filler spool: 60 mm flanges 3 mm, 30 mm barrel 25 mm wide, 8 mm arbor hole, line tie slot
let flange = 60.0; // [40.0, 100.0] Flange diameter (mm)
let barrel = 30.0; // [20.0, 60.0] Barrel diameter (mm)
let width = 25.0; // [15.0, 40.0] Line width (mm)
let arbor = 8.0; // [6.0, 16.0] Arbor hole (mm)
let s = cylinder(flange / 2.0, 3.0) + cylinder([0, 0, 2.99], "Z", barrel / 2.0, width + 0.02) + cylinder([0, 0, width + 3.0], "Z", flange / 2.0, 3.0);
s - cylinder([0, 0, -1], "Z", arbor / 2.0, width + 8.0) - box_from_corners([flange / 2.0 - 6.0, -0.5, width + 2.0], [flange / 2.0 + 1.0, 0.5, width + 7.0])
