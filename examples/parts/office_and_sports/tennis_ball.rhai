// Tennis ball: 67 mm diameter, 3.2 mm rubber shell, hollow core, with the shallow seam groove approximated by two offset tori
let d = 67.0; // [65.4, 68.6] Diameter (mm)
let r = d / 2.0;
let ball = sphere(r) - sphere(r - 3.2);
let seam1 = torus(r * 0.62, 0.6).translate([0, 0, r * 0.78]);
let seam2 = torus(r * 0.62, 0.6).rotate_x(90.0).translate([0, -r * 0.78, 0]);
ball - seam1 - seam2
