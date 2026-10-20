// Glass balustrade D-clamp for 10 mm glass: 50 x 45 mm D body 28 mm thick, 10.5 mm glass slot 20 mm deep, flat back for a 42 mm post
let glass = 10.0; // [8.0, 13.5] Glass thickness (mm)
let width = 50.0; // [40.0, 65.0] Clamp width (mm)
let height = 45.0; // [35.0, 55.0] Clamp height (mm)
let depth = 28.0; // [22.0, 35.0] Clamp depth (mm)
let body = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, depth, height]);
let d = body.fillet(width / 2.0 - 0.5, body.edges("|Y and >Z"));
let slot = box_from_corners([-width, depth - 20.0, (height - glass - 0.5) / 2.0], [width, depth + 1.0, (height + glass + 0.5) / 2.0]);
let post = cylinder([0, -21.0 + 3.0, -1], "Z", 21.0, height + 2.0);
d - slot - post - cylinder([0, -1, height / 2.0], "Y", 2.75, depth)
