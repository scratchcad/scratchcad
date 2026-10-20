// V-slot Delrin wheel: 24.4 mm OD, 10.2 mm wide, V profile, two 625 bearing pockets (16 mm)
let outer_d = 24.4; // [20.0, 32.0] Outside diameter (mm)
let width = 10.2; // [8.0, 14.0] Width (mm)
let v_depth = 3.0; // [2.0, 5.0] V depth (mm)
let bearing_d = 16.0; // [10.0, 22.0] Bearing pocket diameter (mm)
let bore = 5.0; // [3.0, 8.0] Spacer bore (mm)
let r = outer_d / 2.0;
let profile = sketch("XZ").move_to(bore / 2.0 + 1.5, 0).hline_to(r - v_depth).line_to(r, width * 0.25).vline_to(width * 0.32)
    .line_to(r - v_depth * 0.6, width / 2.0).line_to(r, width * 0.68).vline_to(width * 0.75).line_to(r - v_depth, width)
    .hline_to(bore / 2.0 + 1.5).close().to_face().revolve("Z", 360);
profile - cylinder([0, 0, -1], "Z", bearing_d / 2.0, 5.0 + 1.0) - cylinder([0, 0, width - 5.0], "Z", bearing_d / 2.0, 6.0)
