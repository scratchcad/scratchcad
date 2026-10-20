// Glasses temple tip sleeve: 35 mm sleeve for a 1.4 mm wire temple, bent 30 degrees at 10 mm, 3.5 mm rising to 4.5 mm section, 1.6 mm wire bore 30 mm deep
let length = 35.0; // [25.0, 45.0] Tip length (mm)
let wire = 1.4; // [1.0, 2.0] Temple wire diameter (mm)
let straight = cylinder([0, 0, 0], "X", 1.75, 10.01);
let curved = cone(1.75, 2.25, length - 10.0).rotate_y(90.0).rotate_y(30.0).translate([10.0, 0, 0]);
let knuckle = sphere([10.0, 0, 0], 1.8);
let end_ = sphere([0, 0, 0], 2.25).translate([10.0 + (length - 10.0) * cos(30.0 * PI() / 180.0), 0, -(length - 10.0) * sin(30.0 * PI() / 180.0)]);
straight + knuckle + curved + end_ - cylinder([-1.0, 0, 0], "X", wire / 2.0 + 0.1, 11.0) - cone(wire / 2.0 + 0.1, 0.3, length - 15.0).rotate_y(90.0).rotate_y(30.0).translate([10.0, 0, 0])
