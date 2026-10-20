// Guitar string winder: 25 x 18 mm peg cup 10 mm deep with a bridge-pin notch, 45 mm crank arm, 12 mm spinning knob
let reach = 45.0; // [30.0, 60.0] Crank radius (mm)
let cup = (box_centered(25.0, 18.0, 12.0).fillet(5.0, "|Z") - box_centered(22.0, 6.0, 12.0).translate([0, 0, -3.0])).translate([0, 0, 6.0]);
let arm = box_from_corners([-5.0, -4.0, 12.0], [reach, 4.0, 16.0]).fillet(2.0, "|Z") + cylinder([0, 0, 11.9], "Z", 9.0, 4.1);
let knob = cylinder([reach, 0, 16.0], "Z", 6.0, 20.0).fillet(2.0, ">Z");
fuse_all([cup, arm, knob]) - box_centered(8.0, 4.0, 6.0).translate([-12.5, 0, 3.0])
