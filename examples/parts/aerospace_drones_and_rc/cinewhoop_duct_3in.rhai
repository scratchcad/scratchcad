// 3 in cinewhoop prop duct: 78 mm bore, 1.5 mm wall 22 mm tall, rounded inlet lip, four 2 mm mounting tabs with M2 holes
let bore = 78.0; // [60.0, 130.0] Duct bore (mm)
let h = 22.0; // [15.0, 35.0] Duct height (mm)
let r = bore / 2.0;
let duct = sketch("XZ").move_to(r, 0).line_to(r, h).arc_to(r + 3.0, h + 3.0, r + 6.0, h).line_to(r + 6.0, h - 1.5).line_to(r + 1.5, h - 1.5).line_to(r + 1.5, 0).close().to_face().revolve("Z", 360);
let tab = box_from_corners([r + 1.0, -5.0, 0], [r + 15.0, 5.0, 2.0]) - cylinder([r + 10.0, 0, -1], "Z", 1.1, 4.0);
let parts = [duct];
for k in 0..4 { parts.push(tab.rotate("Z", 45.0 + k.to_float() * 90.0)); }
fuse_all(parts)
