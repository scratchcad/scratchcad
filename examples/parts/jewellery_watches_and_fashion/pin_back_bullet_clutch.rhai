// Bullet pin-back clutch for a 1 mm lapel-pin post: 6 mm flange 0.6 mm thick, 3.8 mm body tapering to 3 mm over 5.5 mm, 0.9 mm friction bore, rounded nose
let flange_diameter = 6.0; // [4.0, 10.0] Flange diameter (mm)
let body_diameter = 3.8; // [2.5, 6.0] Body diameter at the flange (mm)
let body_length = 5.5; // [3.0, 9.0] Body length (mm)
let bore = 0.9; // [0.6, 1.4] Post bore diameter (mm)
let rf = flange_diameter / 2.0;
let rb = min(body_diameter / 2.0, rf - 0.3);
let rt = rb * 0.78;
let rh = bore / 2.0;
let profile = sketch("XZ")
    .move_to(rh, 0)
    .hline_to(rf)
    .vline_to(0.6)
    .hline_to(rb)
    .line_to(rt, body_length - 0.8)
    .arc_to(rt * 0.8, body_length - 0.15, rh + 0.25, body_length)
    .hline_to(rh)
    .close();
profile.to_face().revolve("Z", 360)
