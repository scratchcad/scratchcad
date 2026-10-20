// Hardened linear shaft 8 mm x 200 mm with chamfered ends and an M4 tapped centre hole each end
let diameter = 8.0; // [3.0, 30.0] Diameter (mm)
let length = 200.0; // [50.0, 1000.0] Length (mm)
let tap = 3.3; // [2.0, 8.0] Tap drill (mm)
let shaft = cylinder(diameter / 2.0, length).chamfer(diameter * 0.06);
shaft - cylinder([0, 0, -1], "Z", tap / 2.0, 11.0) - cylinder([0, 0, length - 10.0], "Z", tap / 2.0, 11.0)
