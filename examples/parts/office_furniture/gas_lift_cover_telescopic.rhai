// Gas lift telescopic cover section: 70 mm OD at the base tapering to 60 mm over 90 mm, 1.5 mm wall, open ends
let base = 70.0; // [55.0, 90.0] Bottom diameter (mm)
let top = 60.0; // [45.0, 80.0] Top diameter (mm)
let height = 90.0; // [60.0, 130.0] Height (mm)
let wall = 1.5; // [1.0, 2.5] Wall (mm)
cone(base / 2.0, top / 2.0, height) - cone(base / 2.0 - wall, top / 2.0 - wall, height + 0.02).translate([0, 0, -0.01])
