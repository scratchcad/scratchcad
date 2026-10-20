// Glass balustrade clamp for 8 mm glass: 50 x 45 mm D-shaped body 25 mm thick with an 8.8 mm glass slot 30 mm deep, M6 pinch screw hole and a 48.3 mm post saddle radius on the back
let glass = 8.8; // [6.8, 12.8] Glass slot width (mm)
let post = 48.3; // [38.0, 60.3] Post diameter (mm)
const w = 50.0;
const h = 45.0;
const t = 25.0;
let body = box_from_corners([-w / 2.0, 0, 0], [w / 2.0, t, h]);
let body = body.fillet(8.0, body.edges("|Y and >Z"));
let slot = box_from_corners([-glass / 2.0, -1.0, h - 30.0], [glass / 2.0, t + 1.0, h + 1.0]);
let saddle = cylinder([0, -post / 2.0 + 4.0, -1.0], "Z", post / 2.0, h + 2.0);
body - slot - saddle - cylinder([-w, t / 2.0, h - 15.0], "X", 3.0, 2.0 * w)
