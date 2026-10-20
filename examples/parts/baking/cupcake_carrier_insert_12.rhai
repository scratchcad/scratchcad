// 12-cupcake carrier insert: 3 x 4 wells 60 mm on 70 mm pitch, 30 mm deep, 1.2 mm thermoformed-style wall
let pitch = 70.0; // [60.0, 85.0] Well pitch (mm)
let well = 60.0; // [50.0, 75.0] Well diameter (mm)
let depth = 30.0; // [20.0, 40.0] Well depth (mm)
let wall = 1.2; // [0.8, 2.0] Wall (mm)
const cols = 4;
const rows = 3;
let w = cols.to_float() * pitch;
let l = rows.to_float() * pitch;
let sheet = box_from_corners([0, 0, depth - wall], [w, l, depth]);
let cups = [];
let holes = [];
for i in 0..cols { for j in 0..rows {
    let x = (i.to_float() + 0.5) * pitch;
    let y = (j.to_float() + 0.5) * pitch;
    cups.push(cone(well / 2.0 - 6.0, well / 2.0, depth).translate([x, y, 0]));
    holes.push(cone(well / 2.0 - 6.0 - wall, well / 2.0 - wall, depth).translate([x, y, wall]));
} }
sheet + fuse_all(cups) - fuse_all(holes)
