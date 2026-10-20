// Fishing float: 30 mm two-tone ball bobber with a 2.5 mm through hole and spring-clip stems top and bottom
let d = 30.0; // [15.0, 50.0] Ball diameter (mm)
let r = d / 2.0;
let ball = sphere(r) + cylinder([0, 0, r - 1.0], "Z", 2.5, 8.0) + cylinder([0, 0, -r - 7.0], "Z", 2.5, 8.0) + torus(r, 0.6);
ball - cylinder([0, 0, -r - 10.0], "Z", 1.25, d + 20.0) - box_centered(0.8, 6.0, 6.0).translate([0, 2.5, r + 4.5])
