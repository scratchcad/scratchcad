// Vacuum crevice tool: 35 mm cuff 32 mm ID, flattened 230 mm nozzle to a 30 x 8 mm angled tip, 2 mm wall
let cuff_id = 32.0; // [30.0, 38.0] Cuff inside diameter (mm)
let length = 230.0; // [150.0, 300.0] Overall length (mm)
let tip_w = 30.0; // [20.0, 40.0] Tip width (mm)
let tip_h = 8.0; // [5.0, 12.0] Tip height (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let cuff = cylinder(cuff_id / 2.0 + wall, 40.0);
let nozzle = loft([circle(plane([0, 0, 40.0], [0, 0, 1]), cuff_id / 2.0 + wall), rect(plane([0, 0, length], [0, 0, 1]), tip_w + 2.0 * wall, tip_h + 2.0 * wall)], true);
let bore = cylinder([0, 0, -1], "Z", cuff_id / 2.0, 41.0) + loft([circle(plane([0, 0, 40.0], [0, 0, 1]), cuff_id / 2.0), rect(plane([0, 0, length + 0.01], [0, 0, 1]), tip_w, tip_h)], true);
let angle_cut = box_centered(100, 100, 100).translate([0, 0, length + 50.0]).rotate([0, 0, length - 10.0], "X", 30.0);
cuff + nozzle - bore - angle_cut
