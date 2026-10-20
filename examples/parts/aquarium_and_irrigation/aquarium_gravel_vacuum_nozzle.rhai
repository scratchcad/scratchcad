// Gravel vacuum nozzle: 50 mm tube 250 mm long tapering to a 16 mm hose spigot, 2 mm wall, angled foot
let tube_d = 50.0; // [35.0, 70.0] Tube diameter (mm)
let length = 250.0; // [150.0, 350.0] Length (mm)
let hose_d = 16.0; // [10.0, 25.0] Hose spigot diameter (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let tube = cylinder(tube_d / 2.0, length) + cone(tube_d / 2.0, hose_d / 2.0, 30.0).translate([0, 0, length - 0.01]) + cylinder([0, 0, length + 29.98], "Z", hose_d / 2.0, 25.0);
let inner = cylinder([0, 0, -1], "Z", tube_d / 2.0 - wall, length + 1.01) + cone(tube_d / 2.0 - wall, hose_d / 2.0 - wall, 30.0).translate([0, 0, length - 0.0]) + cylinder([0, 0, length + 29.98], "Z", hose_d / 2.0 - wall, 26.0);
let foot = box_centered(tube_d * 3.0, tube_d * 3.0, tube_d).rotate_x(30.0).translate([0, 0, -tube_d * 0.3]);
tube - inner - foot
