// Figure skate guard spring clip: 40 mm C-clip 10 mm wide, 2 mm thick, joining the two halves of a sprung blade guard with 6 mm hook ends
let span = 40.0; // [30.0, 60.0] Clip span (mm)
let width = 10.0; // [6.0, 15.0] Clip width (mm)
const t = 2.0;
let back = box_from_corners([0, 0, 0], [span, width, t]);
let hooks = box_from_corners([0, 0, 0], [t, width, 6.0]) + box_from_corners([span - t, 0, 0], [span, width, 6.0]) + box_from_corners([0, 0, 6.0 - t], [4.0, width, 6.0]) + box_from_corners([span - 4.0, 0, 6.0 - t], [span, width, 6.0]);
back + hooks
