// Bib / dummy clip: 45 x 15 mm spring clip, 3 mm jaw gap with teeth, 10 mm strap slot 3 mm
let length = 45.0; // [30.0, 60.0] Clip length (mm)
let width = 15.0; // [10.0, 20.0] Clip width (mm)
let t = 2.5; // [1.5, 3.5] Wall (mm)
let gap = 3.0; // [1.5, 5.0] Jaw gap (mm)
let outer = box_from_corners([0, 0, 0], [length, width, gap + 2.0 * t]);
let o = outer.fillet(gap / 2.0 + t - 0.01, outer.edges("|Y and <X"));
let inner = box_from_corners([t + 4.0, -1, t], [length + 1.0, width + 1.0, gap + t]);
let teeth = [];
for k in 0..5 { teeth.push(box_from_corners([length - 15.0 + k.to_float() * 3.0, 0, t - 0.01], [length - 14.0 + k.to_float() * 3.0, width, t + 0.8])); }
o - inner + fuse_all(teeth) - box_from_corners([1.5, 2.5, -1], [4.5, width - 2.5, gap + 2.0 * t + 1.0])
