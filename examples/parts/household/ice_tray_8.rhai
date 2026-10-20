// Ice cube tray: 2 x 4 cavities of 30 x 30 x 25 mm with drafted walls, 2 mm rim, 140 x 75 mm
let rows = 2; // [1, 4] Rows
let cols = 4; // [1, 8] Columns
let cube = 30.0; // [15.0, 50.0] Cube size (mm)
let depth = 25.0; // [10.0, 40.0] Depth (mm)
let wall = 2.0; // [1.0, 4.0] Wall thickness (mm)
let pitch = cube + wall;
let w = cols.to_float() * pitch + wall; let h = rows.to_float() * pitch + wall;
let tray = box(w, h, depth + wall);
let cav = loft([rect(cube * 0.85, cube * 0.85), rect(plane([0, 0, depth + 0.5], "Z"), cube, cube)], true);
let cavities = [];
for i in 0..cols { for j in 0..rows { cavities.push(cav.translate([wall + pitch / 2.0 - wall / 2.0 + i.to_float() * pitch, wall + pitch / 2.0 - wall / 2.0 + j.to_float() * pitch, wall])); } }
tray - fuse_all(cavities)
