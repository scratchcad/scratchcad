// Launch pad blast deflector: 100 mm steel plate 3 mm with a 45 degree cone deflector 40 mm and 1/8 in rod hole
let size = 100.0; // [60.0, 150.0] Plate size (mm)
let t = 3.0; // [2.0, 6.0] Plate thickness (mm)
let rod = 3.6; // [3.2, 6.5] Rod hole (mm)
let plate = box_centered(size, size, t).translate([0, 0, t / 2.0]);
let p = plate.fillet(6.0, plate.edges("|Z"));
let cone_ = cone(20.0, 2.0, 18.0).translate([15.0, 0, t - 0.01]);
p + cone_ - cylinder([-15.0, 0, -1], "Z", rod / 2.0, t + 2.0)
