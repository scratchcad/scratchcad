// Magnetic knife strip end cap: fits a 40 x 15 mm bar, 25 mm sleeve 2 mm wall, rounded end, 4.5 mm screw hole
let w = 40.0; // [30.0, 60.0] Bar height (mm)
let t = 15.0; // [10.0, 25.0] Bar thickness (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let outer = box_from_corners([0, -wall, -wall], [25.0, t + wall, w + wall]);
let o = outer.fillet(t / 2.0 + wall - 0.5, outer.edges("|Z and >X"));
o - box_from_corners([-1, 0, 0], [20.0, t, w]) - cylinder([10.0, -wall - 1.0, w / 2.0], "Y", 2.25, wall + 2.0)
