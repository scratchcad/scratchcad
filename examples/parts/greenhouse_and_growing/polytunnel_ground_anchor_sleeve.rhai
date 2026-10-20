// Polytunnel ground anchor sleeve: 35 mm ID foundation tube socket for a 32 mm hoop, 300 mm long with 3 mm wall, 40 degree driving point with a 4 mm drain hole, 70 mm anti-twist fin plate 4 mm thick and an M8 locking bolt boss 30 mm below the top
// # Socket
let hoop = 32.0; // [25.0, 42.0] Hoop tube diameter (mm)
let length = 300.0; // [200.0, 500.0] Sleeve length (mm)
let wall = 3.0; // [2.5, 5.0] Wall thickness (mm)
// # Ground
let fin_w = 70.0; // [40.0, 100.0] Fin width (mm)
let fin_h = 120.0; // [60.0, 200.0] Fin height (mm)
let bolt = 8.0; // [6.0, 10.0] Locking bolt diameter (mm)
let ri = hoop / 2.0 + 1.5;
let ro = ri + wall;
let point_h = ro / (20.0 * PI() / 180.0).tan();
let tube = cylinder([0, 0, point_h - 0.01], "Z", ro, length - point_h + 0.01);
let point = cone(1.0, ro, point_h);
let bore = cylinder([0, 0, point_h + wall], "Z", ri, length);
let drain = cylinder([0, 0, point_h - 10.0], "Z", 2.0, wall + 12.0);
let fins = [box_from_corners([-fin_w / 2.0, -2.0, point_h + 20.0], [fin_w / 2.0, 2.0, point_h + 20.0 + fin_h]).chamfer(8.0, "|Y and <Z"), box_from_corners([-2.0, -fin_w / 2.0, point_h + 20.0], [2.0, fin_w / 2.0, point_h + 20.0 + fin_h]).chamfer(8.0, "|X and <Z")];
let boss = cylinder([0, 0, length - 30.0], "X", bolt / 2.0 + 4.0, ro + 8.0);
let bolt_hole = cylinder([0, 0, length - 30.0], "X", bolt / 2.0 * 0.85, ro + 10.0);
(fuse_all([tube, point]) + fuse_all(fins) + boss) - bore - drain - bolt_hole
