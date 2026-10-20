// Tent peg puller: 100 mm handle 25 mm wide 6 mm, 20 mm hook slot 5 mm wide, finger hole 22 mm
let length = 100.0; // [70.0, 140.0] Puller length (mm)
let width = 25.0; // [18.0, 35.0] Width (mm)
let t = 6.0; // [4.0, 10.0] Thickness (mm)
let body = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, t]);
let b = body.fillet(width / 2.0 - 0.5, body.edges("|Z"));
let slot = box_from_corners([length - 25.0, -2.5, -1], [length + 1.0, 2.5, t + 1.0]) + box_from_corners([length - 25.0, -2.5, -1], [length - 18.0, 8.0, t + 1.0]);
b - slot - cylinder([18.0, 0, -1], "Z", width * 0.44, t + 2.0)
