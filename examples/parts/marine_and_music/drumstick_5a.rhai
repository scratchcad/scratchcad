// 5A drumstick: 14.4 mm diameter, 406 mm long, long taper to an acorn tip 10 mm across
let len = 406.0; // [380.0, 430.0] Length (mm)
let d = 14.4; // [12.0, 16.0] Diameter (mm)
let r = d / 2.0;
let profile = sketch("XZ").move_to(0, 0).line_to(r - 1.0, 0).arc_to(r - 0.3, 0.3, r, 1.0).line_to(r, len * 0.62).line_to(3.3, len - 22.0).line_to(2.6, len - 14.0).arc_to(5.0, len - 6.0, 0, len).close();
profile.to_face().revolve("Z", 360)
