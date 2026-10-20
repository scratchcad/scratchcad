// Porcelain spot plate: 100 x 80 x 12 mm with 12 spherical wells 20 mm across and 6 mm deep, chamfered edges
let cols = 4; // [2, 6] Columns
let rows = 3; // [2, 5] Rows
let w = cols.to_float() * 24.0 + 4.0;
let d = rows.to_float() * 24.0 + 8.0;
let R = (100.0 + 36.0) / 12.0;
let plate = box_centered(w, d, 12.0).translate([0, 0, 6.0]).chamfer(1.5, ">Z");
let wells = [];
for i in 0..cols { for j in 0..rows { wells.push(sphere([(i.to_float() - (cols - 1).to_float() / 2.0) * 24.0, (j.to_float() - (rows - 1).to_float() / 2.0) * 24.0, 12.0 + R - 6.0], R)); } }
plate - fuse_all(wells)
