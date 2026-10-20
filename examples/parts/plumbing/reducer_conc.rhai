// Concentric pipe reducer 2 in to 1 in (60.3 to 33.4 mm), Sch 40 walls, 64 mm long, butt-weld ends
let large_od = 60.3; // [30.0, 170.0] Large end OD (mm)
let small_od = 33.4; // [15.0, 120.0] Small end OD (mm)
let length = 64.0; // [30.0, 150.0] Length (mm)
let wall = 3.9; // [2.0, 10.0] Wall (mm)
let flat = length * 0.18;
let profile = sketch("XZ").move_to(large_od / 2.0 - wall, 0).hline_to(large_od / 2.0).vline_to(flat).line_to(small_od / 2.0, length - flat).vline_to(length)
    .hline_to(small_od / 2.0 - wall).vline_to(length - flat).line_to(large_od / 2.0 - wall, flat).close();
profile.to_face().revolve("Z", 360)
