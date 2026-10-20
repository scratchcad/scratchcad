// Queue rope barrier post cap: 60 mm cap for a 51 mm post, 25 mm tall with 3 mm walls, a 2 mm chamfered flat top, and two opposing 12 mm rope hook eyes
let post = 51.0; // [38.0, 63.5] Post OD (mm)
let height = 25.0; // [18.0, 40.0] Cap height (mm)
const wall = 3.0;
let r = post / 2.0 + 0.3;
let c = cylinder([0, 0, 0], "Z", r + wall, height) - cylinder([0, 0, -1.0], "Z", r, height - wall + 1.0);
let c = c.chamfer(2.0, c.edges(">Z"));
let eyes = [];
for sx in [-1.0, 1.0] { eyes.push(cylinder([sx * (r + wall + 6.0), -3.0, height / 2.0], "Y", 8.0, 6.0) - cylinder([sx * (r + wall + 6.0), -4.0, height / 2.0], "Y", 5.0, 8.0) + box_from_corners([sx * (r + wall) - 2.0, -3.0, height / 2.0 - 4.0], [sx * (r + wall) + 2.0, 3.0, height / 2.0 + 4.0])); }
c + fuse_all(eyes)
