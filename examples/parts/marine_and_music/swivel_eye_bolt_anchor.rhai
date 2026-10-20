// Anchor chain swivel, 8 mm: 70 mm eye-to-eye, oval eye 22 x 30 mm of 10 mm wire on a jaw body with a 12 mm swivel pin
let wire = 10.0; // [6.0, 16.0] Wire diameter (mm)
let r = wire / 2.0;
let eye = torus(13.0 + r, r).scale(1.0).rotate_x(90.0).translate([0, 0, 0]);
let shank = cylinder([0, 0, -r - 30.0], "Z", 6.0, 32.0) + cylinder([0, 0, -r - 34.0], "Z", 9.0, 4.0);
let jaw = box_centered(30.0, 14.0, 26.0).translate([0, 0, -r - 50.0]) - box_centered(18.0, 16.0, 18.0).translate([0, 0, -r - 58.0]) - cylinder([-16.0, 0, -r - 60.0], "X", 4.0, 32.0) - cylinder([0, 0, -r - 40.0], "Z", 6.3, 6.0);
compound([eye + shank, jaw])
