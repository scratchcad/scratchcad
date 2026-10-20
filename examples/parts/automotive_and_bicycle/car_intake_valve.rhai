// Intake poppet valve: 34 mm head, 7 mm stem, 105 mm long, 45 deg seat, tulip neck, keeper groove near the tip
let head = 34.0; // [25.0, 45.0] Head diameter (mm)
let stem = 7.0; // [5.0, 8.0] Stem diameter (mm)
let length = 105.0; // [90.0, 125.0] Overall length (mm)
let rh = head / 2.0;
let rs = stem / 2.0;
let profile = sketch("XZ").move_to(0, 0).line_to(rh, 0).line_to(rh, 1.2).line_to(rh - 2.0, 3.2)
    .arc_to(rs + 2.5, 7.5, rs, 18.0)
    .line_to(rs, length - 6.0).line_to(rs - 0.6, length - 5.4).line_to(rs - 0.6, length - 4.0).line_to(rs, length - 3.4)
    .line_to(rs, length - 0.5).line_to(rs - 0.5, length).line_to(0, length).close();
profile.to_face().revolve("Z", 360)
