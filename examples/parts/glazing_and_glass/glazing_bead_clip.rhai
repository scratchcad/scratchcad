// uPVC glazing bead clip: 20 mm wide spring clip, 1.2 mm section, 10 mm base with a 5 mm barbed leg and a 6 mm hook that grips the bead
let width = 20.0; // [12.0, 30.0] Clip width (mm)
let leg = 5.0; // [3.0, 8.0] Barb leg length (mm)
const t = 1.2;
let base = box_from_corners([0, 0, 0], [10.0, width, t]);
let leg_ = box_from_corners([2.0, 0, -leg], [2.0 + t, width, 0.01]) + box_from_corners([2.0 + t - 0.01, 0, -leg], [3.5 + t, width, -leg + 1.0]);
let hook = box_from_corners([10.0 - t, 0, 0], [10.0, width, 6.0]) + box_from_corners([7.0, 0, 6.0 - t], [10.0, width, 6.0]);
base + leg_ + hook
