// Golf ball line marking cup: holds a 42.67 mm ball in a 43.2 mm half-shell 4 mm thick with a 1.5 mm pen slot across the top, on a 50 mm flat base
let ball = 42.67; // [42.0, 43.0] Ball diameter (mm)
let slot = 1.5; // [1.0, 2.5] Pen slot width (mm)
const wall = 4.0;
let r = ball / 2.0 + 0.3;
let shell = sphere([0, 0, r + 2.0], r + wall) - sphere([0, 0, r + 2.0], r) - box_centered(3.0 * r, 3.0 * r, 2.0 * r).translate([0, 0, r + 2.0 + r * 1.0 + r * 0.6]);
let base = cylinder([0, 0, 0], "Z", 25.0, 2.01);
let s = (shell & box_from_corners([-2.0 * r, -2.0 * r, 0], [2.0 * r, 2.0 * r, 3.0 * r])) + base;
s - box_from_corners([-slot / 2.0, -2.0 * r, r + 2.0], [slot / 2.0, 2.0 * r, 3.0 * r])
