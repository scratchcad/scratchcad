// E3D V6 heat break: 22.2 mm long, M7 thread 7 mm at top, M6 thread 5.5 mm at bottom, 2 mm thin neck, 2 mm bore
let length = 22.2; // [18.0, 30.0] Length (mm)
let neck_d = 2.8; // [2.2, 4.0] Thin-wall neck diameter (mm)
let bore = 2.0; // [1.8, 4.2] Bore (mm)
let profile = sketch("XZ").move_to(bore / 2.0, 0).hline_to(3.0).vline_to(5.5).hline_to(neck_d / 2.0).vline_to(7.5).hline_to(3.0).vline_to(length - 7.0)
    .hline_to(3.5).vline_to(length).hline_to(bore / 2.0).close();
profile.to_face().revolve("Z", 360)
