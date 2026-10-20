// Cubicle curtain track glider for a ward C-track with a 6 mm slot: 13 x 20 x 5 mm carriage with chamfered ends, 4 mm neck 9 mm long and a 12 mm eye with a 6 mm hole for the curtain hook
let carriage_w = 13.0; // [10.0, 18.0] Carriage width (mm)
let carriage_l = 20.0; // [14.0, 30.0] Carriage length (mm)
let neck = 9.0; // [6.0, 15.0] Neck length (mm)
const neck_t = 4.0;
const eye_r = 6.0;
let car = box_centered(carriage_w, carriage_l, 5.0);
car = car.chamfer(1.5, car.edges("|X and >Z"));
let n = box_centered(neck_t, 8.0, neck + 1.0).translate([0, 0, -2.5 - neck / 2.0]);
let ez = -2.5 - neck - eye_r + 1.0;
let eye = cylinder([-neck_t / 2.0, 0, ez], "X", eye_r, neck_t) - cylinder([-neck_t / 2.0 - 1.0, 0, ez], "X", 3.0, neck_t + 2.0);
car + n + eye
