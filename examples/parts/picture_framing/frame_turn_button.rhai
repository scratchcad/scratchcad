// Picture frame turn button: 30 x 10 x 2 mm swivel tab with rounded ends, a 3.5 mm screw hole 7 mm from one end and a 1 mm step underneath so it overhangs the backing board
let length = 30.0; // [20.0, 45.0] Button length (mm)
let step = 1.0; // [0.5, 3.0] Backing board step (mm)
const t = 2.0;
const w = 10.0;
let b = box_from_corners([w / 2.0, -w / 2.0, 0], [length - w / 2.0, w / 2.0, t]) + cylinder([w / 2.0, 0, 0], "Z", w / 2.0, t) + cylinder([length - w / 2.0, 0, 0], "Z", w / 2.0, t);
let foot = cylinder([w / 2.0, 0, -step], "Z", w / 2.0, step + 0.01);
b + foot - cylinder([7.0, 0, -step - 1.0], "Z", 1.75, t + step + 2.0)
