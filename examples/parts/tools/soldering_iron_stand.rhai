// Soldering iron stand: 100 mm weighted base 10 mm thick with a 60 mm sponge tray, 12 mm post, 40 deg conical iron holder 70 mm long
let base_d = 100.0; // [80.0, 160.0] Base diameter (mm)
let tilt = 40.0; // [20.0, 41.0] Holder tilt (deg)
let base = cylinder(base_d / 2.0, 10.0).chamfer(1.5, ">Z") - cylinder([-base_d / 4.0 + 2.0, 0, 6.0], "Z", base_d * 0.2, 5.0);
let post = cylinder([base_d / 4.0, 0, 9.0], "Z", 6.0, 45.0);
let holder = (cone(14.0, 22.0, 70.0) - cone(12.5, 20.5, 70.0).translate([0, 0, 0.01]) - cylinder([0, 0, -1], "Z", 8.0, 3.0)).rotate_y(-tilt).translate([base_d / 4.0, 0, 52.0]);
fuse_all([base, post, holder])
