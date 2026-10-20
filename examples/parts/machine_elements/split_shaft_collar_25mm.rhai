// One-piece clamp shaft collar for a 25 mm shaft: 45 mm OD, 15 mm wide, 1 mm slit, M6 clamp screw with 10 mm counterbore
let bore = 25.0; // [10.0, 40.0] Bore diameter (mm)
let outer_diameter = 45.0; // [25.0, 70.0] Outer diameter (mm)
let width = 15.0; // [8.0, 25.0] Width (mm)
let slit = 1.0; // [0.5, 2.0] Slit width (mm)
const clearance = 6.6;
const tap = 5.0;
const counterbore = 10.0;
let ri = bore / 2.0;
let ro = max(outer_diameter / 2.0, ri + 10.0);
let xs = (ri + ro) / 2.0;
let collar = cylinder(ro, width) - cylinder([0, 0, -1], "Z", ri, width + 2.0);
collar = collar.chamfer(0.6, "%CIRCLE");
let gap = box_from_corners([0, -slit / 2.0, -1], [ro + 1.0, slit / 2.0, width + 1.0]);
let zc = width / 2.0;
let hole_clear = cylinder([xs, 0, zc], "Y", clearance / 2.0, ro + 1.0);
let hole_cb = cylinder([xs, ri * 0.55, zc], "Y", counterbore / 2.0, ro);
let hole_tap = cylinder([xs, 0.1, zc], "-Y", tap / 2.0, ro * 0.8);
collar - fuse_all([hole_clear, hole_cb, hole_tap]) - gap
