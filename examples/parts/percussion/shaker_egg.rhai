// Egg shaker: 45 x 60 mm egg shell 2 mm wall, two halves joined at a 30 mm high snap band (two solids)
let width = 45.0; // [35.0, 55.0] Egg diameter (mm)
let height = 60.0; // [45.0, 75.0] Egg height (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let r = width / 2.0;
let low = sphere([0, 0, r], r) & box_from_corners([-r, -r, 0], [r, r, r]);
let lower = low - sphere([0, 0, r], r - wall) + (cylinder([0, 0, r - 0.01], "Z", r - wall, 4.0) - cylinder([0, 0, r - 1.0], "Z", r - 2.0 * wall, 6.0));
let top_h = height - r;
let upper = loft([circle(plane([0, 0, r + 0.5], [0, 0, 1]), r), circle(plane([0, 0, r + top_h * 0.5], [0, 0, 1]), r * 0.85), circle(plane([0, 0, height - 3.0], [0, 0, 1]), r * 0.35), circle(plane([0, 0, height], [0, 0, 1]), 0.5)], true);
let up_shell = upper - loft([circle(plane([0, 0, r + 0.49], [0, 0, 1]), r - wall), circle(plane([0, 0, r + top_h * 0.5], [0, 0, 1]), r * 0.85 - wall), circle(plane([0, 0, height - wall - 3.0], [0, 0, 1]), r * 0.35 - wall * 0.5)], true);
compound([lower, up_shell])
