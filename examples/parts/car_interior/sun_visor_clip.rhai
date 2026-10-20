// Sun visor retaining clip: 30 x 20 mm base 3 mm with 2 screw holes, 10 mm visor-rod snap for an 8 mm rod
let rod = 8.0; // [6.0, 12.0] Visor rod diameter (mm)
let length = 30.0; // [20.0, 40.0] Base length (mm)
let width = 20.0; // [12.0, 30.0] Base width (mm)
let base = box_from_corners([-length / 2.0, -width / 2.0, 0], [length / 2.0, width / 2.0, 3.0]);
let b = base.fillet(4.0, base.edges("|Z"));
let snap = cylinder([0, -width / 2.0, 3.0 + rod / 2.0 + 0.5], "Y", rod / 2.0 + 2.0, width) - cylinder([0, -width / 2.0 - 1.0, 3.0 + rod / 2.0 + 0.5], "Y", rod / 2.0, width + 2.0) - box_from_corners([-rod * 0.35, -width, 3.0 + rod * 0.9], [rod * 0.35, width, 3.0 + rod + 5.0]);
let s = snap & box_from_corners([-length, -width, 2.99], [length, width, 30.0]);
b + s - cylinder([-11.0, 0, -1], "Z", 2.1, 5.0) - cylinder([11.0, 0, -1], "Z", 2.1, 5.0)
