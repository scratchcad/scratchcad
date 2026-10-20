// Bat box landing strip: 200 x 100 mm plate 6 mm with horizontal grip grooves 2 mm every 6 mm, 2 hanging holes
let width = 200.0; // [150.0, 300.0] Plate width (mm)
let height = 100.0; // [60.0, 150.0] Plate height (mm)
let t = 6.0; // [4.0, 10.0] Thickness (mm)
let plate = box_from_corners([0, 0, 0], [width, height, t]);
let grooves = [];
let n = ((height - 10.0) / 6.0).floor().to_int();
for k in 0..n { grooves.push(box_from_corners([-1, 5.0 + k.to_float() * 6.0, t - 1.0], [width + 1.0, 7.0 + k.to_float() * 6.0, t + 1.0])); }
plate - compound(grooves) - cylinder([15.0, height - 10.0, -1], "Z", 3.0, t + 2.0) - cylinder([width - 15.0, height - 10.0, -1], "Z", 3.0, t + 2.0)
