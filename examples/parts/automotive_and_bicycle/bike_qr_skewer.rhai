// Front quick-release skewer: 5 mm rod 148 mm long, cam housing with 60 mm lever and paddle, conical 18 mm adjusting nut
let len = 148.0; // [125.0, 180.0] Rod length (mm)
let rod = cylinder([0, 0, 0], "X", 2.5, len);
let nut = cone(9.0, 7.0, 10.0).rotate_y(90.0).translate([len - 12.0, 0, 0]);
let housing = cylinder([-10.0, 0, 0], "X", 9.0, 10.5);
let hinge = cylinder([-14.0, -9.0, 4.0], "Y", 6.0, 18.0);
let lever = box_from_corners([-16.0, -6.0, 6.0], [44.0, 6.0, 10.0]);
let paddle = cylinder([44.0, 0, 6.0], "Z", 8.0, 4.0);
fuse_all([rod, nut, housing, hinge, lever, paddle])
