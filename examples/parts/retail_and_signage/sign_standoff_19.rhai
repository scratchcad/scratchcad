// Sign standoff, 19 mm x 25 mm: barrel with M6 tapped base, 6 mm acrylic gap, 19 mm cap with 2 mm chamfer
let diameter = 19.0; // [12.0, 30.0] Diameter (mm)
let barrel_l = 25.0; // [13.0, 50.0] Barrel length (mm)
let cap_l = 10.0; // [6.0, 15.0] Cap length (mm)
let barrel = cylinder(diameter / 2.0, barrel_l) - cylinder([0, 0, -1], "Z", 2.5, barrel_l - 4.0) - cylinder([0, 0, barrel_l - 8.0], "Z", 3.0, 10.0);
let cap = cylinder([0, 0, barrel_l + 6.0], "Z", diameter / 2.0, cap_l);
let c = cap.chamfer(2.0, cap.edges(">Z"));
let stud = cylinder([0, 0, barrel_l - 7.0], "Z", 3.0, 13.01);
barrel + c + stud
