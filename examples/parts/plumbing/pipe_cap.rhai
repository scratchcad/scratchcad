// Butt-weld pipe cap for 2 in pipe: 60.3 mm OD, 3.9 mm wall, elliptical 2:1 head 38 mm tall
let pipe_od = 60.3; // [21.3, 219.1] Pipe OD (mm)
let wall = 3.9; // [2.0, 12.0] Wall (mm)
let height = 38.0; // [20.0, 150.0] Height (mm)
let r = pipe_od / 2.0;
let straight = height - r * 0.5;
let outer = cylinder(r, straight) + (sphere([0, 0, straight], r) & box_centered(pipe_od, pipe_od, r).translate([0, 0, straight + r / 2.0])).scale([0, 0, straight], 1.0);
let head = cylinder(r, straight) + (sphere(r).scale(1.0)).translate([0, 0, straight]) & box_centered(pipe_od * 2.0, pipe_od * 2.0, straight + r * 0.5).translate([0, 0, (straight + r * 0.5) / 2.0]);
head.shell(-wall, "<Z")
