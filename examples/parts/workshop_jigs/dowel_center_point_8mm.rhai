// Dowel centre point (dowel marker) for 8 mm holes: 7.9 mm shank 8 mm long, 10 mm collar 1.5 mm, 2 mm marking point
let hole_d = 8.0; // [5.0, 14.0] Dowel hole diameter (mm)
let shank_l = 8.0; // [5.0, 12.0] Shank length (mm)
let collar_t = 1.5; // [1.0, 3.0] Collar thickness (mm)
let point_h = 2.0; // [1.0, 3.0] Point height (mm)
let rs = hole_d / 2.0 - 0.05;
let shank = cylinder(rs, shank_l + 0.5);
let s = shank.chamfer(0.5, shank.edges("<Z"));
let collar = cylinder([0, 0, shank_l], "Z", rs + 1.0, collar_t);
let point = cone(1.2, 0.0, point_h).translate([0, 0, shank_l + collar_t - 0.01]);
s + collar + point
