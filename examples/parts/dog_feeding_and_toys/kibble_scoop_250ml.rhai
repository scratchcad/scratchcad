// Pet food scoop, about 250 ml: 80 x 70 mm box scoop 60 mm deep with 2.5 mm walls, an open front lip angled, and a 100 mm handle 20 x 10 mm
let width = 70.0; // [50.0, 100.0] Scoop width (mm)
let depth = 60.0; // [40.0, 80.0] Scoop depth (mm)
const wall = 2.5;
const length = 80.0;
let s = box_from_corners([0, 0, 0], [length, width, depth]) - box_from_corners([wall, wall, wall], [length + 1.0, width - wall, depth + 1.0]);
let lip = face(polygon([[length * 0.5, -1.0, depth + 0.01], [length + 1.0, -1.0, depth + 0.01], [length + 1.0, -1.0, depth * 0.4]])).extrude([0, width + 2.0, 0]);
let handle = box_from_corners([-100.0, width / 2.0 - 10.0, depth - 10.0], [0.01, width / 2.0 + 10.0, depth]);
s - lip + handle
