// OO single-track tunnel portal: 70 mm wide arch 42 mm opening x 55 mm tall, 85 x 75 mm stone face, 5 mm thick
let opening = 42.0; // [38.0, 60.0] Opening width (mm)
let clearance = 55.0; // [50.0, 70.0] Opening height (mm)
let width = 85.0; // [70.0, 140.0] Face width (mm)
let height = 75.0; // [60.0, 100.0] Face height (mm)
let t = 5.0; // [3.0, 8.0] Thickness (mm)
let face = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, t, height]);
let arch_r = opening / 2.0;
let hole = box_from_corners([-arch_r, -1, -1], [arch_r, t + 1.0, clearance - arch_r]) + cylinder([0, -1, clearance - arch_r], "Y", arch_r, t + 2.0);
let voussoirs = cylinder([0, -1.0, clearance - arch_r], "Y", arch_r + 5.0, 1.01) - cylinder([0, -2.0, clearance - arch_r], "Y", arch_r, 4.0) & box_from_corners([-width, -2, clearance - arch_r], [width, 1, height]);
let coping = box_from_corners([-width / 2.0 - 2.0, -2.0, height - 4.0], [width / 2.0 + 2.0, t + 1.0, height]);
let pilasters = box_from_corners([-width / 2.0, -2.0, 0], [-width / 2.0 + 8.0, 0.01, height - 3.99]) + box_from_corners([width / 2.0 - 8.0, -2.0, 0], [width / 2.0, 0.01, height - 3.99]);
face + voussoirs + coping + pilasters - hole
