// Nail-on chair glide: 22 mm disc 2 mm thick with a 3 mm dome, 2.4 mm nail 12 mm long with a point
let d = 22.0; // [16.0, 40.0] Diameter (mm)
let r = d / 2.0;
let R = (r * r + 9.0) / 6.0;
let dome = sphere([0, 0, 5.0 - R], R) & cylinder([0, 0, 2.0], "Z", r, 3.0);
let nail = cylinder([0, 0, -12.0], "Z", 1.2, 12.1) + cone(0.2, 1.2, 2.0).translate([0, 0, -14.0]);
fuse_all([cylinder(r, 2.0), dome, nail]).rotate_x(180.0)
