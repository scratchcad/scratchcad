// Luggage tag frame: 95 x 55 mm frame 3 mm thick with an 85 x 45 mm card window, a 1 mm card slot from one end and a 15 x 5 mm strap slot
let width = 95.0; // [80.0, 120.0] Tag width (mm)
let height = 55.0; // [45.0, 70.0] Tag height (mm)
const t = 3.0;
let f = box_from_corners([0, 0, 0], [width, height, t]);
let f = f.fillet(6.0, f.edges("|Z"));
let window = box_from_corners([10.0, 5.0, 2.0], [width - 5.0, height - 5.0, t + 1.0]);
let slot = box_from_corners([8.0, 4.0, 0.9], [width + 1.0, height - 4.0, 1.9]);
let strap = box_from_corners([2.5, height / 2.0 - 7.5, -1.0], [7.5, height / 2.0 + 7.5, t + 1.0]);
f - window - slot - strap
