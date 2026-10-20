// MX switch plate, 3 x 3 macropad: 1.5 mm plate, 14 x 14 mm cutouts on a 19.05 mm pitch, 6 mm border with four M2 mounting holes
let cols = 3; // [1, 6] Columns
let rows = 3; // [1, 4] Number of rows
let t = 1.5; // [1.2, 1.6] Plate thickness (mm)
const pitch = 19.05;
const border = 6.0;
let w = cols.to_float() * pitch + 2.0 * border;
let h = rows.to_float() * pitch + 2.0 * border;
let plate = box_from_corners([0, 0, 0], [w, h, t]);
let plate = plate.fillet(3.0, plate.edges("|Z"));
let cuts = [];
for c in 0..cols { for r in 0..rows { cuts.push(box_centered(14.0, 14.0, t + 2.0).translate([border + pitch * (c.to_float() + 0.5), border + pitch * (r.to_float() + 0.5), t / 2.0])); } }
for p in [[3.0, 3.0], [w - 3.0, 3.0], [3.0, h - 3.0], [w - 3.0, h - 3.0]] { cuts.push(cylinder([p[0], p[1], -1.0], "Z", 1.1, t + 2.0)); }
plate - fuse_all(cuts)
