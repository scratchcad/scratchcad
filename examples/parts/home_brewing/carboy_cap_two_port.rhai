// Carboy cap with 2 ports: fits a 32 mm neck, 38 mm cap 30 mm tall 2 mm wall, two 9 mm port nipples 15 mm
let neck = 32.0; // [25.0, 45.0] Neck diameter (mm)
let height = 30.0; // [20.0, 40.0] Cap height (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let c = cylinder(neck / 2.0 + wall, height) - cylinder([0, 0, -1], "Z", neck / 2.0 - 0.5, height - wall + 1.0);
let ports = [];
for x in [-neck * 0.22, neck * 0.22] { ports.push(cylinder([x, 0, height - 0.01], "Z", 4.5, 15.0) - cylinder([x, 0, height - wall - 1.0], "Z", 3.0, 20.0)); }
c + fuse_all(ports) - cylinder([-neck * 0.22, 0, height - wall - 1.0], "Z", 3.0, 4.0) - cylinder([neck * 0.22, 0, height - wall - 1.0], "Z", 3.0, 4.0)
