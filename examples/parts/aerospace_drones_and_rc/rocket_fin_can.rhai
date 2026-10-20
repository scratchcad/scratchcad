// Three-fin model rocket fin can for BT-60: 80 mm sleeve, 0.8 mm wall, 3 mm swept trapezoidal fins (70 mm root, 30 mm tip, 45 mm span)
let R = 20.8; // [9.0, 33.0] Tube outer radius (mm)
let span = 45.0; // [20.0, 80.0] Fin span (mm)
let fins = 3; // [3, 4] Fins
let can = cylinder(R + 0.8, 80.0) - cylinder([0, 0, -1], "Z", R, 82.0);
let fin = polygon([[R + 0.4, 0, 5], [R + 0.4, 0, 75], [R + span, 0, 35], [R + span, 0, 5]]).to_face().extrude([0, 3.0, 0]).translate([0, -1.5, 0]);
for k in 0..fins { can += fin.rotate("Z", k.to_float() * 360.0 / fins.to_float()); }
can
