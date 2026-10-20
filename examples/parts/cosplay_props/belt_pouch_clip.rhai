// Utility belt pouch clip: slides on a 50 mm belt, 55 mm wide, 3 mm thick, 40 mm tall with a 4 mm belt gap and a 20 x 10 mm pouch tab with 2 rivet holes
let belt = 50.0; // [30.0, 60.0] Belt width (mm)
let gap = 4.0; // [2.0, 8.0] Belt thickness gap (mm)
const t = 3.0;
let w = belt + 5.0;
let back = box_from_corners([0, 0, 0], [w, t, 40.0]);
let front = box_from_corners([0, t + gap, 10.0], [w, 2.0 * t + gap, 40.0]);
let top = box_from_corners([0, 0, 40.0 - t], [w, 2.0 * t + gap, 40.0]);
let tab = box_from_corners([w / 2.0 - 10.0, -0.01 - t, -10.0], [w / 2.0 + 10.0, 1.0, 10.0]);
back + front + top + tab - cylinder([w / 2.0 - 5.0, -t - 1.0, -4.0], "Y", 1.5, t + 2.0) - cylinder([w / 2.0 + 5.0, -t - 1.0, -4.0], "Y", 1.5, t + 2.0)
