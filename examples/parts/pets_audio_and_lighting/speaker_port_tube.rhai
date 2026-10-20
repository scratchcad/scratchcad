// Bass reflex port tube: 50 mm bore 120 mm long with 3 mm wall, 10 mm flared inner end, 80 mm mounting flange with four screw holes
let bore = 50.0; // [30.0, 100.0] Port diameter (mm)
let len = 120.0; // [50.0, 250.0] Port length (mm)
let r = bore / 2.0;
let port = sketch("XZ").move_to(r, 0).line_to(r, len - 10.0).arc_to(r + 3.0, len - 3.0, r + 10.0, len).line_to(r + 13.0, len).arc_to(r + 5.0, len - 6.0, r + 3.0, len - 12.0).line_to(r + 3.0, 0).close().to_face().revolve("Z", 360);
let flange = cylinder(r + 15.0, 4.0) - cylinder([0, 0, -1], "Z", r, 6.0);
for k in 0..4 { flange -= cylinder([r + 9.0, 0, -1], "Z", 2.0, 6.0).rotate_z(45.0 + k.to_float() * 90.0); }
port + flange
