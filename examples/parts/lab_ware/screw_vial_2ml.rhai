// 2 ml autosampler vial 12 x 32 mm: 1 mm wall, 9 mm neck with two thread ridges; 12 mm screw cap with an 6 mm septum hole beside it
let h = 32.0; // [25.0, 45.0] Vial height (mm)
let p = [[0, 0, 0], [5.0, 0, 0], [6.0, 0, 1.0], [6.0, 0, h - 7.0], [4.5, 0, h - 5.5], [4.5, 0, h], [3.5, 0, h], [3.5, 0, h - 5.5], [5.0, 0, h - 7.0], [5.0, 0, 1.0], [0, 0, 1.0]];
let vial = polygon(p).to_face().revolve("Z", 360) + torus(4.5, 0.35).translate([0, 0, h - 1.5]) + torus(4.5, 0.35).translate([0, 0, h - 3.5]);
let cap = cylinder(6.0, 7.5) - cylinder([0, 0, -1], "Z", 4.9, 7.0) - cylinder([0, 0, 5.0], "Z", 3.0, 5.0);
compound([vial, cap.translate([16.0, 0, 0])])
