// Tent pole ferrule for 8.5 mm poles: 8.0 mm insert 55 mm long, 8.5 mm collar, 7.2 mm shock-cord bore
let pole_d = 8.5; // [6.0, 12.0] Pole outside diameter (mm)
let insert_d = 7.0; // [5.0, 10.0] Insert diameter (mm)
let insert_l = 55.0; // [35.0, 80.0] Insert length (mm)
let collar = cylinder(pole_d / 2.0, 3.0) + cylinder([0, 0, 2.99], "Z", insert_d / 2.0, insert_l / 2.0 + 0.01) + cylinder([0, 0, -insert_l / 2.0], "Z", insert_d / 2.0 - 0.3, insert_l / 2.0 + 0.01);
let c = collar.chamfer(0.5, collar.edges("%CIRCLE and (>Z or <Z)"));
c - cylinder([0, 0, -insert_l], "Z", 2.0, insert_l * 2.0)
