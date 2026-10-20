// Xylophone bar, C5: 280 x 38 x 22 mm rosewood with an undercut arch 16 mm deep, two cord holes at the nodes (22.4% from each end)
let len = 280.0; // [150.0, 400.0] Bar length (mm)
let w = 38.0; // [30.0, 50.0] Width (mm)
let t = 22.0; // [15.0, 28.0] Thickness (mm)
let bar = box_from_corners([0, 0, 0], [len, w, t]).chamfer(1.0, ">Z");
let R = (len * len * 0.25 * 0.36 + 16.0 * 16.0) / (2.0 * 16.0);
bar = bar - cylinder([len / 2.0, -1, 16.0 - R], "Y", R, w + 2.0);
for f in [0.224, 0.776] { bar -= cylinder([len * f, -1, t * 0.82], "Y", 1.8, w + 2.0); }
bar
