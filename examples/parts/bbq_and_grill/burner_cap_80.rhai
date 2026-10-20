// Gas hob burner cap: 80 mm cap 8 mm thick, 6 mm rim skirt 3 mm, 2 locating pegs 4 mm
let diameter = 80.0; // [50.0, 110.0] Cap diameter (mm)
let t = 8.0; // [5.0, 12.0] Cap thickness (mm)
let cap = cylinder(diameter / 2.0, t);
let c = cap.chamfer(2.0, cap.edges(">Z"));
let skirt = cylinder([0, 0, -6.0], "Z", diameter / 2.0 - 4.0, 6.01) - cylinder([0, 0, -7.0], "Z", diameter / 2.0 - 7.0, 7.0);
let pegs = cylinder([diameter / 2.0 - 9.5, 0, -9.0], "Z", 2.0, 9.01) + cylinder([-diameter / 2.0 + 9.5, 0, -9.0], "Z", 2.0, 9.01);
c + skirt + pegs - cylinder([0, 0, -1], "Z", diameter / 2.0 - 12.0, 1.5)
