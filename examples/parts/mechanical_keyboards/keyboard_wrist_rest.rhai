// Keyboard wrist rest: 140 x 80 mm, 18 mm tall at the back sloping to 12 mm at the front, 4 mm rounded back edge and four 10 mm rubber-foot recesses 1 mm deep underneath
let length = 140.0; // [100.0, 360.0] Rest length (mm)
let back_h = 18.0; // [14.0, 26.0] Back height (mm)
const depth = 80.0;
const front_h = 12.0;
let body = face(polygon([[0, 0, 0], [0, depth, 0], [0, depth, back_h], [0, 0, front_h]])).extrude([length, 0, 0]);
let body = body.fillet(4.0, body.edges("|X and >Z"));
let feet = [];
for x in [15.0, length - 15.0] { for y in [12.0, depth - 12.0] { feet.push(cylinder([x, y, -1.0], "Z", 5.0, 2.0)); } }
body - fuse_all(feet)
