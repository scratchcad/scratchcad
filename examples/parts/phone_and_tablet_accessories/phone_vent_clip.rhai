// Car vent phone mount clip: 20 mm forked vent clip with 1.8 mm slat gap, 15 mm prongs and a 17 mm ball stud on a 10 mm neck for a ball-joint cradle
let gap = 1.8; // [1.0, 3.0] Vent slat thickness gap (mm)
let ball = 17.0; // [14.0, 20.0] Ball diameter (mm)
const prong = 15.0;
let body = box_from_corners([-10.0, -6.0, 0], [10.0, 6.0, 6.0]);
let prongs = box_from_corners([-10.0, -gap / 2.0 - 1.5, -prong], [10.0, gap / 2.0 + 1.5, 0.01]) - box_from_corners([-11.0, -gap / 2.0, -prong - 1.0], [11.0, gap / 2.0, -2.0]);
let barb = box_from_corners([-10.0, -gap / 2.0, -prong], [10.0, gap / 2.0, -prong + 1.0]).rotate_x(0.0) - box_from_corners([-11.0, -gap / 4.0, -prong - 1.0], [11.0, gap / 4.0, -prong + 2.0]);
let neck = cylinder([0, 0, 5.99], "Z", 5.0, 10.0);
let b = sphere([0, 0, 16.0 + ball / 2.0 - 2.0], ball / 2.0);
body + prongs + barb + neck + b
