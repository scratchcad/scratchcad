// Rain gauge funnel: standard 127 mm (5 in) collector funnel with a sharp 45 degree knife-edge rim, 60 mm deep cone to a 10 mm spout 30 mm long, 2 mm wall and a 100 mm locating skirt that sits in the measuring cylinder housing
// # Collector
let rim_d = 127.0; // [100.0, 203.0] Rim diameter (mm)
let cone_depth = 60.0; // [40.0, 100.0] Cone depth (mm)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
// # Spout
let spout_d = 10.0; // [6.0, 16.0] Spout diameter (mm)
let spout_length = 30.0; // [15.0, 50.0] Spout length (mm)
let skirt_d = 100.0; // [70.0, 160.0] Locating skirt diameter (mm)
const rim_band = 25.0;
let R = rim_d / 2.0;
let rs = spout_d / 2.0;
let top = spout_length + cone_depth + rim_band;
let outer = sketch("XZ").move_to(rs, 0).hline_to(rs + wall).vline_to(spout_length).line_to(R + wall, spout_length + cone_depth).vline_to(top - wall).line_to(R, top).line_to(R, spout_length + cone_depth + wall).line_to(rs, spout_length + wall * 1.2).close().to_face().revolve("Z", 360);
let sk = min(skirt_d / 2.0, R - 6.0);
let zs = spout_length + cone_depth * (sk - rs) / (R - rs);
let skirt = cylinder([0, 0, zs - 20.0], "Z", sk, 22.0) - cylinder([0, 0, zs - 21.0], "Z", sk - wall, 40.0);
let skirt_trim = sketch("XZ").move_to(0, spout_length).line_to(R, spout_length + cone_depth).vline(40.0).hline_to(0).close().to_face().revolve("Z", 360);
outer + (skirt - skirt_trim)
