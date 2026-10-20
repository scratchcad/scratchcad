// Barrier tape dispenser hub: fits a 75 mm tape core, 50 mm wide, 3 mm flange 100 mm diameter, 6 spokes, 12 mm axle bore with a 25 mm boss
let core = 75.0; // [50.0, 80.0] Tape core diameter (mm)
let tape_width = 50.0; // [40.0, 80.0] Tape width (mm)
let flange = 100.0; // [80.0, 150.0] Flange diameter (mm)
let axle = 12.0; // [8.0, 20.0] Axle bore (mm)
let spokes = 6; // [3, 10] Number of spokes
let rim = cylinder(core / 2.0 - 0.3, tape_width + 3.0) - cylinder([0, 0, -1], "Z", core / 2.0 - 3.3, tape_width + 5.0);
let fl = cylinder(flange / 2.0, 3.0) - cylinder([0, 0, -1], "Z", core / 2.0 - 3.3, 5.0);
let boss = cylinder(12.5, tape_width + 3.0);
let arms = [];
for k in 0..spokes { arms.push(box_from_corners([0, -3.0, 0], [core / 2.0 - 3.0, 3.0, tape_width + 3.0]).rotate_z(k.to_float() * 360.0 / spokes.to_float())); }
(rim + fl + boss + fuse_all(arms)) - cylinder([0, 0, -1], "Z", axle / 2.0, tape_width + 5.0)
