// Darkroom print tongs: 180 mm tong arm 10 mm wide, 3 mm thick with a 30 mm flat rubber-tip pad 2 mm raised ribs and a 6 mm hinge hole (one arm of a pair)
let length = 180.0; // [140.0, 230.0] Tong length (mm)
let width = 10.0; // [8.0, 14.0] Arm width (mm)
const t = 3.0;
let arm = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, t]) + cylinder([0, 0, 0], "Z", width / 2.0 + 2.0, t);
let pad = box_from_corners([length - 30.0, -width / 2.0 - 3.0, 0], [length, width / 2.0 + 3.0, t]);
let ribs = [];
for i in 0..5 { ribs.push(box_from_corners([length - 28.0 + i.to_float() * 6.0, -width / 2.0 - 3.0, t - 0.01], [length - 26.0 + i.to_float() * 6.0, width / 2.0 + 3.0, t + 2.0])); }
arm + pad + fuse_all(ribs) - cylinder([0, 0, -1.0], "Z", 3.0, t + 2.0)
