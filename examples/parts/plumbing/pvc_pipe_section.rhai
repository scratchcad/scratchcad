// 32 mm PVC pressure pipe section: 32 mm OD, 2.4 mm wall, 200 mm long with a 45 mm belled socket end
let outer_d = 32.0; // [16.0, 160.0] Outside diameter (mm)
let wall = 2.4; // [1.5, 10.0] Wall (mm)
let length = 200.0; // [50.0, 1000.0] Length (mm)
let bell = 45.0; // [20.0, 120.0] Socket length (mm)
let profile = sketch("XZ").move_to(outer_d / 2.0 - wall, 0).hline_to(outer_d / 2.0).vline_to(length - bell - 10.0).line_to(outer_d / 2.0 + wall, length - bell)
    .vline_to(length).hline_to(outer_d / 2.0 + 0.1).vline_to(length - bell).line_to(outer_d / 2.0 - wall, length - bell - 10.0).close();
profile.to_face().revolve("Z", 360)
