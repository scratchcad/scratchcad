// Acoustic guitar bridge pin: 5.1 mm shank with 3 degree taper, 7 mm head, 1.5 mm string slot, 26 mm long
let shank_d = 5.1; // [4.5, 5.5] Shank diameter at the head (mm)
let length = 26.0; // [20.0, 30.0] Overall length (mm)
let head_d = 7.0; // [6.0, 9.0] Head diameter (mm)
let taper = 3.0; // [1.0, 5.0] Included taper (degrees)
let shank_l = length - 4.0;
let tip_r = shank_d / 2.0 - shank_l * (taper / 2.0 * PI() / 180.0).tan();
let shank = cone(tip_r, shank_d / 2.0, shank_l);
let head = cylinder([0, 0, shank_l - 0.01], "Z", head_d / 2.0, 2.0) + sphere([0, 0, shank_l + 2.0], head_d / 2.0) & box_from_corners([-5, -5, 0], [5, 5, length]);
let pin = shank + head;
pin - box_from_corners([shank_d / 2.0 - 0.8, -0.75, 2.0], [5.0, 0.75, shank_l]) - sphere([0, 0, -1.0], 1.2)
