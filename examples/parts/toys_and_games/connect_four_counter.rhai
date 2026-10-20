// Connect-four style counter: 33 mm disc 6 mm thick with a raised rim and concentric grip ring on both faces
let d = 33.0; // [25.0, 40.0] Diameter (mm)
let r = d / 2.0;
let c = cylinder(r, 6.0).fillet(0.8, "%CIRCLE") - cylinder([0, 0, 5.2], "Z", r - 2.0, 2.0) - cylinder([0, 0, -1.2], "Z", r - 2.0, 2.0);
c + torus(r * 0.5, 0.6).translate([0, 0, 5.2]) + torus(r * 0.5, 0.6).translate([0, 0, 0.8])
