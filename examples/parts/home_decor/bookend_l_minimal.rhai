// Minimal L bookend: 130 mm upright, 100 x 120 mm base plate 3 mm with 12 mm radius bend and 2 gussets
let height = 130.0; // [80.0, 200.0] Upright height (mm)
let width = 120.0; // [80.0, 160.0] Width (mm)
let base = 100.0; // [60.0, 150.0] Base depth (mm)
let t = 3.0; // [2.0, 5.0] Thickness (mm)
let b = box_from_corners([0, 0, 0], [width, base, t]);
let u = box_from_corners([0, 0, 0], [width, t, height]);
let g = [];
for x in [20.0, width - 20.0 - t] { g.push(polygon([[x, t - 0.01, t - 0.01], [x, t + 30.0, t - 0.01], [x, t - 0.01, t + 30.0]]).to_face().extrude([t, 0, 0])); }
b + u + fuse_all(g)
