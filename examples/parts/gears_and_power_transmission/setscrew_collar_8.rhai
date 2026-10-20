// Set-screw shaft collar for an 8 mm shaft: 16 mm OD, 8 mm wide, one M4 set screw
let bore = 8.0; // [3.0, 30.0] Bore (mm)
let outer_d = 16.0; // [8.0, 50.0] Outside diameter (mm)
let width = 8.0; // [4.0, 16.0] Width (mm)
let collar = (cylinder(outer_d / 2.0, width) - cylinder([0, 0, -1], "Z", bore / 2.0, width + 2.0)).chamfer(0.4, "%CIRCLE");
collar - cylinder([0, 0, width / 2.0], "Y", 1.65, outer_d)
