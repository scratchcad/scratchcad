// Plasterboard spring toggle wing: 50 x 12 mm folding wing 8 mm tall, U-section 1 mm steel style with a 5 mm M5 thread boss at the pivot and two 1.5 mm pivot holes
let length = 50.0; // [35.0, 70.0] Wing span (mm)
let width = 12.0; // [9.0, 16.0] Wing width (mm)
const t = 1.0;
const h = 8.0;
let u = box_from_corners([-length / 2.0, -width / 2.0, 0], [length / 2.0, width / 2.0, h]) - box_from_corners([-length / 2.0 - 1.0, -width / 2.0 + t, t], [length / 2.0 + 1.0, width / 2.0 - t, h + 1.0]);
let boss = cylinder([0, 0, 0], "Z", 3.5, h) - cylinder([0, 0, -1.0], "Z", 2.1, h + 2.0);
u - cylinder([0, 0, -1.0], "Z", 3.5, 3.0) + boss - cylinder([0, -width, h / 2.0], "Y", 0.75, 2.0 * width)
