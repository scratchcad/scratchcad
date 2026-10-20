// Solid set-screw shaft collar for a 20 mm shaft: 36 mm OD, 14 mm wide, one radial M6 set screw hole, 0.8 mm chamfers
let bore = 20.0; // [6.0, 50.0] Bore diameter (mm)
let outer_diameter = 36.0; // [12.0, 80.0] Outer diameter (mm)
let width = 14.0; // [6.0, 30.0] Width (mm)
let screw_diameter = 5.0; // [2.5, 10.0] Set screw tap drill (mm)
let ro = max(outer_diameter, bore + 8.0) / 2.0;
let collar = cylinder(ro, width) - cylinder([0, 0, -1], "Z", bore / 2.0, width + 2.0);
collar = collar.chamfer(0.8, "%CIRCLE");
let sd = min(screw_diameter, width * 0.6);
collar - cylinder([0, 0, width / 2.0], "X", sd / 2.0, ro + 1.0)
