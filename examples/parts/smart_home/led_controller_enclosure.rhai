// LED strip controller enclosure: 60 x 35 x 20 mm, 1.6 mm wall, 5.5 mm DC jack hole, 2 cable slots 8 x 3 mm, lid lip
let length = 60.0; // [40.0, 90.0] Length (mm)
let width = 35.0; // [25.0, 50.0] Width (mm)
let height = 20.0; // [12.0, 30.0] Height (mm)
let wall = 1.6; // [1.2, 2.5] Wall (mm)
let outer = box_centered(length, width, height).translate([0, 0, height / 2.0]);
let o = outer.fillet(3.0, outer.edges("|Z"));
let inner = box_centered(length - 2.0 * wall, width - 2.0 * wall, height).translate([0, 0, height / 2.0 + wall]);
let i = inner.fillet(1.5, inner.edges("|Z"));
let lip = box_centered(length - wall, width - wall, 1.5).translate([0, 0, height - 0.75]) - box_centered(length - 2.0 * wall, width - 2.0 * wall, 3.0).translate([0, 0, height]);
o - i - lip - cylinder([-length / 2.0 - 1.0, 0, height / 2.0], "X", 5.5, wall + 2.0) - box_centered(wall * 3.0, 8.0, 3.0).translate([length / 2.0, -8.0, height / 2.0]) - box_centered(wall * 3.0, 8.0, 3.0).translate([length / 2.0, 8.0, height / 2.0])
