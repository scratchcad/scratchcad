// Fence post cap for 100 mm square posts: pyramid top 25 mm, 15 mm skirt, 2.5 mm wall
let post = 100.0; // [70.0, 150.0] Post size (mm)
let skirt = 15.0; // [10.0, 30.0] Skirt depth (mm)
let peak = 25.0; // [10.0, 50.0] Pyramid height (mm)
let wall = 2.5; // [1.5, 4.0] Wall (mm)
let o = post + 2.0 * wall + 1.0;
let cap = box_centered(o, o, skirt).translate([0, 0, skirt / 2.0]) + loft([rect(plane([0, 0, skirt - 0.01], [0, 0, 1]), o + 6.0, o + 6.0), rect(plane([0, 0, skirt + peak], [0, 0, 1]), 2.0, 2.0)], true);
cap - box_centered(post + 1.0, post + 1.0, skirt * 2.0)
