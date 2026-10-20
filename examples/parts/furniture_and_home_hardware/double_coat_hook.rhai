// Double coat hook: 20 x 60 x 4 mm back plate with two screw holes, 8 mm rod hooks swept with mitred bends, ball ends
let rod = 4.0; // [3.0, 6.0] Rod radius (mm)
let reach = 45.0; // [30.0, 70.0] Lower hook reach (mm)
let plate = box_from_corners([-4.0, -10.0, -30.0], [0, 10.0, 30.0]).fillet(3.0, "|X");
for z in [-20.0, 20.0] { plate -= cylinder([-5.0, 0, z], "X", 2.0, 6.0); }
let lower = circle([-1.0, 0, -10.0], [reach - 10.0, 0, -15.0], rod).to_face().sweep(polyline([[-1.0, 0, -10.0], [reach - 11.0, 0, -25.0], [reach, 0, -10.0]]));
let upper = circle([-1.0, 0, 10.0], [26.0, 0, 15.0], rod).to_face().sweep(polyline([[-1.0, 0, 10.0], [25.0, 0, 25.0], [28.0, 0, 38.0]]));
fuse_all([plate, lower, upper, sphere([reach, 0, -10.0], rod + 1.0), sphere([28.0, 0, 38.0], rod + 1.0)])
