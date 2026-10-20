// Jigsaw puzzle piece: 25 mm square, 2 mm thick, two round tabs (right, top) and two sockets (left, bottom)
let s = 25.0; // [15.0, 50.0] Piece size (mm)
let t = 2.0; // [1.0, 4.0] Thickness (mm)
let k = s * 0.16;
let piece = box_from_corners([0, 0, 0], [s, s, t]);
piece += cylinder([s + k * 0.8, s / 2.0, 0], "Z", k, t) + box_from_corners([s - 0.1, s / 2.0 - k * 0.5, 0], [s + k * 0.5, s / 2.0 + k * 0.5, t]);
piece += cylinder([s / 2.0, s + k * 0.8, 0], "Z", k, t) + box_from_corners([s / 2.0 - k * 0.5, s - 0.1, 0], [s / 2.0 + k * 0.5, s + k * 0.5, t]);
piece -= cylinder([k * 0.8, s / 2.0, -1], "Z", k + 0.15, t + 2.0) + box_from_corners([-1, s / 2.0 - k * 0.5 - 0.15, -1], [k * 0.5, s / 2.0 + k * 0.5 + 0.15, t + 1.0]);
piece - cylinder([s / 2.0, k * 0.8, -1], "Z", k + 0.15, t + 2.0) - box_from_corners([s / 2.0 - k * 0.5 - 0.15, -1, -1], [s / 2.0 + k * 0.5 + 0.15, k * 0.5, t + 1.0])
