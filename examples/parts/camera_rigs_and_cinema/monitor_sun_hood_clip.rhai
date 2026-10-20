// Spring clip that holds a fabric sun hood on a 7 inch monitor: grips a 22 mm thick monitor edge, 15 mm wide, 1.8 mm wall C-section with 12 mm deep front and back jaws, 1 mm gripping beads at the jaw tips, and a 1.5 mm wide 5 mm deep hood-panel slot along the top
let monitor_t = 22.0; // [12.0, 35.0] Monitor thickness (mm)
let jaw = 12.0; // [6.0, 20.0] Jaw depth (mm)
let width = 15.0; // [10.0, 25.0] Clip width (mm)
const wall = 1.8;
let a = monitor_t / 2.0;
let profile = polygon([
    [-a - wall, 0, -jaw], [-a + 1.0, 0, -jaw], [-a + 1.0, 0, -jaw + 1.5], [-a, 0, -jaw + 2.5], [-a, 0, 0],
    [a, 0, 0], [a, 0, -jaw + 2.5], [a - 1.0, 0, -jaw + 1.5], [a - 1.0, 0, -jaw], [a + wall, 0, -jaw],
    [a + wall, 0, wall + 6.0], [-a - wall, 0, wall + 6.0]]);
let clip = face(profile).extrude([0, width, 0]);
let slot = box_from_corners([-0.75, -1.0, wall + 1.0], [0.75, width + 1.0, wall + 7.0]);
clip - slot
