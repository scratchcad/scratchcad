// Soldering iron stand: 100 x 70 mm base 8 mm, 45 degree 22 mm cradle 60 mm long, 55 mm sponge tray
let base_l = 100.0; // [80.0, 150.0] Base length (mm)
let base_w = 70.0; // [50.0, 100.0] Base width (mm)
let cradle = 22.0; // [15.0, 30.0] Cradle bore (mm)
let base = box_from_corners([0, -base_w / 2.0, 0], [base_l, base_w / 2.0, 8.0]);
let b = base.fillet(8.0, base.edges("|Z"));
let tray = box_from_corners([base_l - 65.0, -base_w / 2.0 + 5.0, 3.0], [base_l - 5.0, base_w / 2.0 - 5.0, 9.0]);
let post = cylinder([20.0, 0, 7.99], "Z", 8.0, 40.0);
let ring = (cylinder([0, 0, 0], "Z", cradle / 2.0 + 3.0, 60.0) - cylinder([0, 0, -1], "Z", cradle / 2.0, 62.0)).rotate_y(45.0).translate([10.0, 0, 40.0]);
let r = ring & box_from_corners([-50, -50, 8.0], [200, 50, 200]);
b - tray + post + r
