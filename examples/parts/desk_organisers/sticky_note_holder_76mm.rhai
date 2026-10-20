// Sticky note holder for 76 x 76 mm pads: 78 mm square pocket 28 mm deep, 3 mm walls, 3 mm floor, 30 mm front thumb notch, two 12 mm pen holes in a side column, chamfered rim
let pad = 76.0; // [50.0, 102.0] Note size (mm)
let depth = 28.0; // [15.0, 45.0] Pocket depth (mm)
let wall = 3.0; // [2.0, 5.0] Wall (mm)
let notch = 30.0; // [20.0, 40.0] Thumb notch width (mm)
let pen = 12.0; // [8.0, 16.0] Pen hole diameter (mm)

const floor_t = 3.0;
let inner = pad + 2.0;
let outer = inner + 2.0 * wall;
let h = depth + floor_t;
let col = pen + wall;
let body = box_from_corners([-outer / 2.0, -outer / 2.0, 0], [outer / 2.0 + col, outer / 2.0, h]);
body = body.fillet(min(wall + 1.0, 4.0), body.edges("|Z"));
body = body - box_centered(inner, inner, h).translate([0, 0, floor_t + h / 2.0]);
let px = outer / 2.0 + col / 2.0 - wall / 2.0;
for y in [-outer / 4.0, outer / 4.0] {
    body = body - cylinder([px, y, floor_t], "Z", pen / 2.0, h);
}
body = body.chamfer(min(0.8, wall * 0.3), body.edges(">Z"));
let nn = min(notch, inner - 10.0);
body - cylinder([0, -outer / 2.0 - 1.0, h], "Y", nn / 2.0, wall + 2.0)
