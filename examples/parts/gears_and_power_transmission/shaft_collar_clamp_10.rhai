// One-piece clamping shaft collar for a 10 mm shaft: 24 mm OD, 9 mm wide, slit with an M3 clamp screw
let bore = 10.0; // [4.0, 40.0] Bore (mm)
let outer_d = 24.0; // [12.0, 70.0] Outside diameter (mm)
let width = 9.0; // [6.0, 20.0] Width (mm)
let screw_d = 3.4; // [2.4, 8.5] Clamp screw hole (mm)
let collar = cylinder(outer_d / 2.0, width) - cylinder([0, 0, -1], "Z", bore / 2.0, width + 2.0);
collar = collar - box_centered(1.0, outer_d, width + 2.0).translate([0, outer_d / 2.0, width / 2.0]);
let screw_y = bore / 2.0 + (outer_d - bore) / 4.0;
collar = collar - cylinder([-outer_d, screw_y, width / 2.0], "X", screw_d / 2.0, outer_d * 2.0);
collar - cylinder([-outer_d / 2.0 - 1.0, screw_y, width / 2.0], "X", screw_d, outer_d / 2.0 - 2.0)
