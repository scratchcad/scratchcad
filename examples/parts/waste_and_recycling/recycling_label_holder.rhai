// Recycling bin label holder: 100 x 60 mm frame 3 mm thick with a 90 x 50 mm label window, 1 mm slide-in channel and two 4 mm cable-tie slots
let width = 100.0; // [70.0, 150.0] Holder width (mm)
let height = 60.0; // [40.0, 100.0] Holder height (mm)
const t = 3.0;
let back = box_from_corners([0, 0, 0], [width, height, 1.5]);
let frame = box_from_corners([0, 0, 1.49], [width, height, t + 1.5]) - box_from_corners([5.0, 5.0, 0], [width - 5.0, height - 5.0, 10.0]);
let channel = box_from_corners([3.5, 3.5, 1.5], [width - 3.5, height + 1.0, 2.5]);
back + frame - channel - box_from_corners([10.0, height / 2.0 - 2.0, -1.0], [14.0, height / 2.0 + 2.0, 3.0]) - box_from_corners([width - 14.0, height / 2.0 - 2.0, -1.0], [width - 10.0, height / 2.0 + 2.0, 3.0])
