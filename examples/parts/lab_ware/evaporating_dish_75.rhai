// 75 mm porcelain evaporating dish: round-bottomed bowl 30 mm deep, 2.5 mm wall, flat foot, pouring lip
let d = 75.0; // [40.0, 150.0] Diameter (mm)
let r = d / 2.0;
let dish = sketch("XZ").move_to(0, 0).line_to(r * 0.4, 0).arc_to(r * 0.85, 8.0, r, 30.0).line_to(r - 2.5, 30.0).arc_to(r * 0.8, 10.0, 0, 2.5).close().to_face().revolve("Z", 360);
let lip = polygon([[r - 4.0, 0, 26.0], [r + 4.0, 0, 31.0], [r - 4.0, 0, 30.0]]).to_face().extrude([0, 10.0, 0]).translate([0, -5.0, 0]);
dish + (lip - cylinder([0, 0, 5.0], "Z", r - 2.6, 30.0))
