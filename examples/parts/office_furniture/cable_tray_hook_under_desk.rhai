// Under-desk cable tray hook: 100 mm J-hook 25 mm wide 3 mm, 60 mm deep basket lip, 2 screw holes
let depth = 60.0; // [40.0, 100.0] Tray depth (mm)
let drop = 100.0; // [60.0, 150.0] Drop below desk (mm)
let width = 25.0; // [15.0, 40.0] Width (mm)
let t = 3.0; // [2.0, 5.0] Thickness (mm)
let top = box_from_corners([0, 0, 0], [40.0, width, t]);
let back = box_from_corners([40.0 - t, 0, -drop], [40.0, width, t]);
let bottom = box_from_corners([40.0 - t, 0, -drop], [40.0 + depth, width, -drop + t]);
let lip = box_from_corners([40.0 + depth - t, 0, -drop], [40.0 + depth, width, -drop + 30.0]);
let s = (top + back + bottom + lip).clean();
s.fillet(1.2, s.edges("|Y")) - cylinder([12.0, width / 2.0, -1], "Z", 2.2, t + 2.0) - cylinder([28.0, width / 2.0, -1], "Z", 2.2, t + 2.0)
