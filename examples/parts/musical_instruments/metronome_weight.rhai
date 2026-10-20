// Pendulum metronome sliding weight: 18 x 14 x 12 mm, 3.2 x 1.2 mm flat bar slot, friction spring pocket
let width = 18.0; // [14.0, 25.0] Width (mm)
let depth = 14.0; // [10.0, 20.0] Depth (mm)
let height = 12.0; // [8.0, 18.0] Height (mm)
let bar_w = 3.2; // [2.0, 5.0] Bar width (mm)
let bar_t = 1.2; // [0.8, 2.0] Bar thickness (mm)
let body = loft([rect(plane([0, 0, 0], [0, 0, 1]), width, depth), rect(plane([0, 0, height], [0, 0, 1]), width * 0.7, depth * 0.8)], true);
let slot = box_centered(bar_w + 0.2, bar_t + 0.2, height * 3.0);
let pocket = box_from_corners([-3.0, bar_t / 2.0 + 0.09, 3.0], [3.0, bar_t / 2.0 + 1.5, height - 3.0]);
body - slot - pocket
