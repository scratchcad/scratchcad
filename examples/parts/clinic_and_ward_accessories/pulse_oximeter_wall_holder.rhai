// Wall holder for a fingertip pulse oximeter: 62 x 36 mm pocket 30 mm deep tilted 15 degrees forward, 2 mm walls, a 30 mm thumb cut in the front and an 80 x 50 x 3 mm back plate with two 4 mm screw holes
let dev_l = 62.0; // [50.0, 75.0] Oximeter length (mm)
let dev_w = 36.0; // [28.0, 45.0] Oximeter width (mm)
let tilt = 15.0; // [0.0, 25.0] Forward tilt (degrees)
const t = 2.0;
const depth = 30.0;
let pocket = box_from_corners([-dev_l / 2.0 - t, -25.0, 0], [dev_l / 2.0 + t, dev_w + 2.0 * t, depth + t]) - box_from_corners([-dev_l / 2.0, t, t], [dev_l / 2.0, dev_w + t, depth + t + 1.0]);
pocket = pocket - box_from_corners([-15.0, dev_w + t - 1.0, depth * 0.4], [15.0, dev_w + 2.0 * t + 1.0, depth + t + 1.0]);
pocket = pocket.rotate([0, 0, 0], "X", -tilt).translate([0, 0, 12.0]) & box_from_corners([-dev_l, -1.5, 0], [dev_l, 100.0, 100.0]);
let plate = box_from_corners([-40.0, -3.0, 0], [40.0, 0.01, 50.0]);
plate + pocket - cylinder([-30.0, -4.0, 40.0], "Y", 2.0, 5.0) - cylinder([30.0, -4.0, 40.0], "Y", 2.0, 5.0)
