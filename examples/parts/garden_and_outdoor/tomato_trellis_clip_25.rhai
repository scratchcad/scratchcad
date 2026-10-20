// Tomato trellis clip: 25 mm ring 10 mm wide for the stem, 2.5 mm wall, 5 mm opening flanked by two pinch tabs with 3 mm twine holes
let ring_diameter = 25.0; // [15.0, 40.0] Ring inside diameter (mm)
let width = 10.0; // [6.0, 16.0] Clip width (mm)
let wall = 2.5; // [1.5, 4.0] Wall thickness (mm)
let opening = 5.0; // [2.0, 10.0] Opening width (mm)
let ri = ring_diameter / 2.0;
let ro = ri + wall;
let ring = cylinder(ro, width) - cylinder([0, 0, -1.0], "Z", ri, width + 2.0);
ring -= box_from_corners([-opening / 2.0, 0, -1.0], [opening / 2.0, ro + 1.0, width + 1.0]);
let tabs = [];
for s in [-1.0, 1.0] {
    let x0 = s * opening / 2.0;
    tabs.push(box_from_corners([x0, ri + 0.5, 0], [x0 + s * wall, ro + 9.0, width]));
}
fuse_all([ring] + tabs) - cylinder([-opening / 2.0 - wall - 1.0, ro + 5.5, width / 2.0], "X", 1.5, opening + 2.0 * wall + 2.0)
