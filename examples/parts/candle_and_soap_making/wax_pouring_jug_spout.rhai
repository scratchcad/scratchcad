// Wax pouring jug: 100 mm dia 120 mm tall jug, 2.5 mm walls, a V pour spout 20 mm wide and a 20 x 90 mm side handle loop 8 mm thick
let dia = 100.0; // [70.0, 140.0] Jug diameter (mm)
let height = 120.0; // [80.0, 160.0] Jug height (mm)
const wall = 2.5;
let r = dia / 2.0;
let body = cylinder([0, 0, 0], "Z", r, height) - cylinder([0, 0, wall], "Z", r - wall, height);
let spout = face(polygon([[r - 4.0, -12.0, height - 0.01], [r - 4.0, 12.0, height - 0.01], [r + 15.0, 0, height + 8.0]])).extrude([0, 0, -20.0]).translate([0, 0, 0]);
let spout_cut = face(polygon([[r - 10.0, -9.0, height + 10.0], [r - 10.0, 9.0, height + 10.0], [r + 16.0, 0, height + 10.0]])).extrude([0, 0, -15.0]);
let handle = box_from_corners([-r - 25.0, -4.0, height * 0.2], [-r + 2.0, 4.0, height * 0.9]) - box_from_corners([-r - 17.0, -5.0, height * 0.2 + 8.0], [-r - 0.5, 5.0, height * 0.9 - 8.0]);
body + (spout - cylinder([0, 0, wall], "Z", r - wall, height + 20.0)) - spout_cut + handle - cylinder([0, 0, wall], "Z", r - wall, height)
