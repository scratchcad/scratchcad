// 1:76 level crossing gate: 12 ft (48 mm) span, 15 mm tall frame, diagonal brace, red target disc 6 mm
let scale_ = 76.0; // [43.5, 160.0] Scale ratio
let s = 76.0 / scale_;
const span = 48.0;
const h = 15.0;
const t = 0.6;
let frame = box_from_corners([0, 0, 0], [span, t, h]) - box_from_corners([1.0, -1, 1.0], [span - 1.0, t + 1.0, h - 1.0]);
let rails = [];
for z in [5.0, 10.0] { rails.push(box_from_corners([0.5, 0, z - 0.4], [span - 0.5, t, z + 0.4])); }
let len = (span * span + h * h).sqrt();
let brace = box_from_corners([0, 0, -0.4], [len, t, 0.4]).rotate_y(-((h - 2.0) / (span - 2.0)).atan() * 180.0 / PI()).translate([1.0, 0, 1.0]) & box_from_corners([0, -1, 0], [span, t + 1.0, h]);
let disc = cylinder([span / 2.0, -0.3, h / 2.0], "Y", 3.0, 0.31);
let post = box_from_corners([-2.0, -1.0, -3.0], [0.01, t + 1.0, h + 4.0]);
(frame + fuse_all(rails) + brace + disc + post).scale(s)
