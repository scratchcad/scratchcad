// Square baluster shoe: fits 41 mm (1 5/8 in) square spindle, 50 x 50 x 12 mm, 2 mm wall, 20 degree stair-rake top cut
let spindle = 41.0; // [30.0, 50.0] Spindle size (mm)
let height = 12.0; // [8.0, 20.0] Shoe height (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let s = box_centered(spindle + 2.0 * wall, spindle + 2.0 * wall, height).translate([0, 0, height / 2.0]);
s - box_centered(spindle + 0.4, spindle + 0.4, height * 3.0) - box_centered(spindle * 2.0, spindle * 3.0, height).translate([0, 0, height * 1.5 + 2.0]).rotate([0, 0, height], "X", 20.0)
