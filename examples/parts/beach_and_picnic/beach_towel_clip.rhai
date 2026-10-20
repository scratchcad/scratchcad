// Beach towel lounger clip: 70 mm jaw clip opening 25 mm for a sunbed tube, 20 mm wide, 3 mm thick with a living spring loop 15 mm and 6 grip teeth
let gap = 25.0; // [15.0, 35.0] Jaw opening (mm)
let width = 20.0; // [15.0, 30.0] Clip width (mm)
const t = 3.0;
let a = box_from_corners([0, 0, 0], [70.0, width, t]);
let b = box_from_corners([0, 0, gap + t], [70.0, width, gap + 2.0 * t]);
let loop_ = cylinder([0, 0, gap / 2.0 + t], "Y", gap / 2.0 + t, width) - cylinder([0, -1.0, gap / 2.0 + t], "Y", gap / 2.0, width + 2.0) - box_from_corners([0, -1.0, 0], [gap, width + 1.0, gap + 2.0 * t]);
let teeth = [];
for i in 0..6 { teeth.push(box_from_corners([30.0 + i.to_float() * 6.0, 0, t - 0.01], [32.0 + i.to_float() * 6.0, width, t + 1.5])); }
a + b + loop_ + fuse_all(teeth)
