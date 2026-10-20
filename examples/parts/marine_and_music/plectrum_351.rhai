// Standard 351-shape guitar pick: 26.5 x 30 mm rounded triangle, 0.73 mm thick, with a 12 mm textured grip dimple
let t = 0.73; // [0.4, 2.0] Thickness (mm)
let pick = sketch().move_to(-13.25, 8.0).arc_to(0, 15.0, 13.25, 8.0).arc_to(8.0, -5.0, 0, -15.0).arc_to(-8.0, -5.0, -13.25, 8.0).close().to_face().extrude(t);
pick - sphere([0, 3.0, t + 20.0 - 0.15], 20.0)
