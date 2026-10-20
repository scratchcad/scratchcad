// Skate boot lace hook: 12 x 8 mm hook plate 1.5 mm with a 3 mm rivet post and an 8 mm curled hook 4 mm wide for 4 mm laces
let lace = 4.0; // [3.0, 6.0] Lace diameter (mm)
let post = 3.0; // [2.0, 4.0] Rivet post diameter (mm)
const t = 1.5;
let plate = box_centered(12.0, 8.0, t).translate([0, 0, t / 2.0]);
let hook = (cylinder([0, -2.0, t + lace / 2.0], "Y", lace / 2.0 + t, 4.0) - cylinder([0, -3.0, t + lace / 2.0], "Y", lace / 2.0, 6.0)) - box_from_corners([-10.0, -3.0, -1.0], [0, 3.0, t + lace / 2.0]);
let p = cylinder([0, 0, -4.0], "Z", post / 2.0, 4.01);
plate + hook + p
