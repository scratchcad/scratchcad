// Cryobox grid divider for 81 cryovials in a 2 inch box: 130 x 130 mm grid of 1.2 mm walls 45 mm tall forming 9 x 9 cells 13.2 mm square, 3 mm finger notches in the outer walls, 4 mm chamfer marking the A1 corner
let cells = 9; // [5, 10] Number of cells per side
let cell = 13.2; // [10.0, 16.0] Cell size (mm)
let height = 45.0; // [30.0, 55.0] Grid height (mm)
let wall = 1.2; // [0.8, 2.0] Wall thickness (mm)
let n = cells.to_float();
let size = n * cell + (n + 1.0) * wall;
let walls = [];
for i in 0..(cells + 1) {
    let p = -size / 2.0 + wall / 2.0 + i.to_float() * (cell + wall);
    walls.push(box_centered(wall, size, height).translate([p, 0, height / 2.0]));
    walls.push(box_centered(size, wall, height).translate([0, p, height / 2.0]));
}
let grid = fuse_all(walls);
// finger notches at the middle of each outer wall
let notches = [];
for k in 0..4 {
    notches.push(cylinder([size / 2.0 - wall * 2.0, 0, height], "X", 6.0, wall * 4.0).rotate_z(k.to_float() * 90.0));
}
grid = grid - fuse_all(notches);
// A1 marker: chamfer the corner cell's outer corner
grid - box_centered(4.0, 4.0, height * 3.0).rotate_z(45.0).translate([-size / 2.0, size / 2.0, 0])
