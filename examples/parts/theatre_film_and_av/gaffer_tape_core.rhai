// Gaffer tape core: 3 in cardboard-style core, 76.2 mm ID, 6 mm wall, 50 mm wide (2 in tape), 1 mm chamfers and a 3 mm hang notch
let id = 76.2; // [50.0, 80.0] Core inside diameter (mm)
let wall = 6.0; // [3.0, 10.0] Wall thickness (mm)
let width = 50.0; // [24.0, 100.0] Core width (mm)
let core = cylinder(id / 2.0 + wall, width) - cylinder([0, 0, -1.0], "Z", id / 2.0, width + 2.0);
let c = core.chamfer(1.0);
c - box_centered(3.0, wall * 3.0, 6.0).translate([0, id / 2.0 + wall / 2.0, width])
