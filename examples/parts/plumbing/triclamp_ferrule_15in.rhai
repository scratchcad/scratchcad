// 1.5 in sanitary tri-clamp ferrule: 50.5 mm flange 2.8 mm thick with gasket groove, 38.1 mm tube stub 21.5 mm long
let flange_d = 50.5; // [34.0, 119.0] Flange diameter (mm)
let tube_od = 38.1; // [12.7, 101.6] Tube OD (mm)
let tube_wall = 1.65; // [1.2, 3.0] Tube wall (mm)
let length = 21.5; // [12.0, 40.0] Ferrule length (mm)
let profile = sketch("XZ").move_to(tube_od / 2.0 - tube_wall, 0).hline_to(tube_od / 2.0).vline_to(length - 5.7).line_to(flange_d / 2.0, length - 2.8)
    .vline_to(length).hline_to(tube_od / 2.0 + 1.0).vline_to(length - 0.9).hline_to(tube_od / 2.0 - tube_wall + 0.5).vline_to(length).hline_to(tube_od / 2.0 - tube_wall).close();
profile.to_face().revolve("Z", 360)
