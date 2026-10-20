// Wheelie bin lid hinge pin: 12 mm pin 60 mm long with a 18 mm head 4 mm thick and a 3 mm R-clip cross hole 5 mm from the end, 1 mm end chamfer
let pin = 12.0; // [8.0, 16.0] Pin diameter (mm)
let length = 60.0; // [40.0, 90.0] Pin length (mm)
let p = cylinder([0, 0, 0], "Z", pin / 2.0, length) + cylinder([0, 0, length - 0.01], "Z", pin / 2.0 + 3.0, 4.0);
let p = p.chamfer(1.0, p.edges("<Z"));
p - cylinder([-pin, 0, 5.0], "X", 1.5, 2.0 * pin)
