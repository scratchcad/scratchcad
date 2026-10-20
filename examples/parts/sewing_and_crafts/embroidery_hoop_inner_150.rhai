// Embroidery hoop inner ring, 150 mm (6 in): 8 mm deep, 6 mm wall, rounded edges
let diameter = 150.0; // [80.0, 300.0] Inside diameter (mm)
let depth = 8.0; // [6.0, 15.0] Ring depth (mm)
let wall = 6.0; // [3.0, 10.0] Wall (mm)
let ring = cylinder(diameter / 2.0 + wall, depth) - cylinder([0, 0, -1], "Z", diameter / 2.0, depth + 2.0);
ring.fillet(1.5, ring.edges("%CIRCLE"))
