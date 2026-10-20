// Aerosol can overcap for a 65 mm can: 66.4 mm diameter, 42 mm tall, 1.2 mm wall, gently domed top, internal snap bead that clips over the can's 65 mm rolled rim, stacking ring on top
let cap_diameter = 66.4; // [50.0, 80.0] Cap diameter (mm)
let height = 42.0; // [25.0, 70.0] Cap height (mm)
let wall = 1.2; // [0.8, 2.0] Wall thickness (mm)
let dome = 3.0; // [1.2, 8.0] Top dome height (mm)
let ro = cap_diameter / 2.0;
let ri = ro - wall;
let hs = height - dome;
let outer = sketch("XZ")
    .move_to(0, 0)
    .hline_to(ro)
    .vline_to(hs - 3.0)
    .arc_to(ro - 0.9, hs - 0.9, ro - 3.0, hs)
    .arc_to(ro * 0.5, hs + dome * 0.8, 0, hs + dome)
    .close()
    .to_face()
    .revolve("Z", 360);
let inner = sketch("XZ")
    .move_to(0, -1.0)
    .hline_to(ri)
    .vline_to(hs - 3.0)
    .arc_to(ri - 0.6, hs - 0.6 - wall, ri - 1.8, hs - wall)
    .arc_to(ri * 0.5, hs + dome * 0.8 - wall, 0, hs + dome - wall)
    .close()
    .to_face()
    .revolve("Z", 360);
let cap = outer - inner;
// snap bead 3 mm above the open edge, a little smaller than the can rim
cap = cap + (cylinder([0, 0, 3.0], "Z", ri + 0.1, 1.2) - cylinder([0, 0, 2.0], "Z", ri - 0.6, 3.0)).chamfer(0.4, "%CIRCLE and <Z");
// stacking ring on the dome
let rs = ro * 0.55;
cap + (cylinder([0, 0, hs], "Z", rs + 1.0, height - hs + 1.5) - cylinder([0, 0, hs - 1.0], "Z", rs, height - hs + 4.0) - sphere([0, 0, -500], 10.0))
