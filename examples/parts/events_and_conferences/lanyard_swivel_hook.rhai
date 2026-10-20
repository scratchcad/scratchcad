// Lanyard swivel hook: 10 mm webbing loop 15 x 4 mm on a 6 mm swivel barrel, with a 25 mm J-hook of 3 mm section
let webbing = 10.0; // [8.0, 20.0] Lanyard width (mm)
let hook = 25.0; // [18.0, 35.0] Hook length (mm)
const s = 3.0;
let loop_ = box_centered(webbing + 5.0, s, 8.0).translate([0, 0, 4.0]) - box_centered(webbing + 0.5, s + 2.0, 3.0).translate([0, 0, 4.5]);
let barrel = cylinder([0, 0, -6.0], "Z", 3.0, 6.01);
let shank = box_from_corners([-s / 2.0, -s / 2.0, -6.0 - hook], [s / 2.0, s / 2.0, -5.99]);
let bend = (cylinder([5.0, -s / 2.0, -6.0 - hook], "Y", 5.0 + s / 2.0, s) - cylinder([5.0, -s, -6.0 - hook], "Y", 5.0 - s / 2.0, 2.0 * s)) - box_from_corners([-10.0, -s, -6.0 - hook], [20.0, s, 0]);
let tip = box_from_corners([10.0 - s / 2.0, -s / 2.0, -6.0 - hook], [10.0 + s / 2.0, s / 2.0, -6.0 - hook + 8.0]);
loop_ + barrel + shank + bend + tip
