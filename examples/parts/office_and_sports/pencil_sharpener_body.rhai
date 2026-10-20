// Hand pencil sharpener: 25 x 15 x 12 mm block, 8 mm conical bore at 23 deg included angle, blade seat 17 x 8 mm with an M2 screw hole
let len = 25.0; // [20.0, 35.0] Body length (mm)
let body = box_centered(len, 15.0, 12.0).translate([0, 0, 6.0]).fillet(1.5, "|X");
let taper = (11.5 * PI() / 180.0).tan();
let bore = cone(4.0, 4.0 - len * 0.6 * taper, len * 0.6).rotate_y(90.0).translate([-len / 2.0 - 0.5, 0, 6.0]);
let seat = box_from_corners([-len / 2.0 + 3.0, -0.5, 9.0], [-len / 2.0 + 20.0, 7.5, 12.5]);
body - bore - seat - cylinder([-len / 2.0 + 15.0, 4.0, 3.0], "Z", 0.8, 10.0)
