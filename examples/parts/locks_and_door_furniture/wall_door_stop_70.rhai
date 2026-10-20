// Wall-mounted door stop: 25 mm dia 70 mm long body with a 3 mm chamfer, 20 mm rubber buffer recess 8 mm deep and a 4.5 mm screw clearance bore with a 9 mm counterbore for the driver
let length = 70.0; // [40.0, 110.0] Projection (mm)
let dia = 25.0; // [20.0, 32.0] Body diameter (mm)
let s = cylinder([0, 0, 0], "Z", dia / 2.0, length);
let s = s.chamfer(2.0, s.edges(">Z"));
let buffer = cylinder([0, 0, length - 8.0], "Z", dia / 2.0 - 2.5, 9.0);
s - buffer - cylinder([0, 0, -1.0], "Z", 2.25, length) - cylinder([0, 0, 6.0], "Z", 4.5, length)
