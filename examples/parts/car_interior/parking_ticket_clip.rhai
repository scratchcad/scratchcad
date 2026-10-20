// Windscreen parking ticket clip: 20 mm suction-cup boss, 40 x 25 mm spring clip jaws 1.5 mm, 3 mm gap
let width = 25.0; // [15.0, 35.0] Clip width (mm)
let length = 40.0; // [30.0, 60.0] Jaw length (mm)
let t = 1.5; // [1.0, 2.5] Jaw thickness (mm)
let gap = 0.5; // [0.2, 3.0] Jaw gap (mm)
let lower = box_from_corners([0, 0, 0], [length, width, t]);
let upper = box_from_corners([4.0, 0, t + gap], [length, width, 2.0 * t + gap]);
let spine = box_from_corners([0, 0, 0], [4.0, width, 2.0 * t + gap + 3.0]);
let lip = box_from_corners([length - 6.0, 0, 2.0 * t + gap - 0.01], [length, width, 2.0 * t + gap + 2.0]);
let boss = cylinder([10.0, width / 2.0, -6.0], "Z", 5.0, 6.01) - cylinder([10.0, width / 2.0, -7.0], "Z", 2.5, 5.0);
lower + upper + spine + lip + boss
