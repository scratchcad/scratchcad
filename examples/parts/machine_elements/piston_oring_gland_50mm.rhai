// Pneumatic piston for a 50 mm bore with a static/dynamic O-ring gland: AS568-227 ring (3.53 mm section, 44.04 mm ID), 2.9 mm gland depth, 4.8 mm groove width, 30 mm long, 12 mm rod hole
let bore = 50.0; // [20.0, 120.0] Cylinder bore (mm)
let length = 30.0; // [21.0, 60.0] Piston length (mm)
let cross_section = 3.53; // [1.78, 6.99] O-ring cross-section (mm)
let gland_depth = 2.9; // [1.3, 6.0] Gland depth (mm)
let groove_width = 4.8; // [2.4, 9.5] Groove width (mm)
let rod_hole = 12.0; // [5.0, 30.0] Rod hole diameter (mm)
const clearance = 0.05;
let rp = bore / 2.0 - clearance;
let rg = bore / 2.0 - gland_depth;
let gw = max(groove_width, cross_section + 0.3);
let piston = cylinder(rp, length).chamfer(0.5, "%CIRCLE");
let zc = length / 2.0;
let groove = cylinder([0, 0, zc - gw / 2.0], "Z", rp + 1.0, gw) - cylinder([0, 0, zc - gw / 2.0 - 1.0], "Z", rg, gw + 2.0);
let wear = cylinder([0, 0, length - 6.0], "Z", rp + 1.0, 3.0) - cylinder([0, 0, length - 7.0], "Z", rp - 0.6, 5.0);
let wear2 = wear.translate([0, 0, -(length - 9.0)]);
piston = piston - compound([groove, wear, wear2]);
piston = piston - cylinder([0, 0, -1], "Z", rod_hole / 2.0, length + 2.0);
let oring = torus(rg + cross_section / 2.0 + 0.03, cross_section / 2.0).translate([0, 0, zc]);
compound([piston, oring])
