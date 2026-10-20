// Sweep oar collar (button): clamps on a 44 mm oar sleeve, 60 mm OD 25 mm wide ring with a flat 8 mm thrust face, 2 mm split and an M5 clamp screw boss
let sleeve_d = 44.0; // [38.0, 50.0] Oar sleeve diameter (mm)
let outer_d = 60.0; // [52.0, 72.0] Collar outer diameter (mm)
let width = 25.0; // [15.0, 35.0] Collar width (mm)
let flange_t = 8.0; // [4.0, 12.0] Thrust face flange thickness (mm)
let split = 2.0; // [1.0, 4.0] Split width (mm)
const screw = 5.3;
const boss = 12.0;
let ri = sleeve_d / 2.0;
let ro = max(outer_d / 2.0, ri + 5.0);
let ring = cylinder(ro - 3.0, width) + cylinder(ro, min(flange_t, width - 4.0));
let lug = box_from_corners([-boss / 2.0 - split / 2.0 - 4.0, ro - 6.0, width - boss - 1.0], [boss / 2.0 + split / 2.0 + 4.0, ro + boss / 2.0, width]).fillet(3.0, "|X and >Y");
let collar = ring + lug - cylinder([0, 0, -1.0], "Z", ri, width + 2.0);
collar = collar - box_from_corners([-split / 2.0, 0, -1.0], [split / 2.0, ro + boss, width + 1.0]);
let sz = width - boss / 2.0 - 0.5;
collar - cylinder([-ro, ro + 1.0, sz], "X", screw / 2.0, 2.0 * ro) - cylinder([boss / 2.0 + split / 2.0 + 0.5, ro + 1.0, sz], "X", 4.6, 10.0)
