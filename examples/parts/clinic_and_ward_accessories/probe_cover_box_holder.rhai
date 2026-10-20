// Wall holder for an electronic thermometer probe cover box: sleeve for a 95 x 55 x 35 mm box, 2 mm walls, 70 mm tall, open top, a 40 x 25 mm dispensing window at the bottom front and a 3 mm floor slot for the covers
let box_w = 95.0; // [70.0, 120.0] Box width (mm)
let box_d = 35.0; // [25.0, 50.0] Box depth (mm)
let height = 70.0; // [50.0, 100.0] Holder height (mm)
const t = 2.0;
let s = box_from_corners([-box_w / 2.0 - t, -t, 0], [box_w / 2.0 + t, box_d + t, height]) - box_from_corners([-box_w / 2.0, 0, t], [box_w / 2.0, box_d, height + 1.0]);
s = s - box_from_corners([-20.0, box_d - 1.0, t + 3.0], [20.0, box_d + t + 1.0, t + 28.0]);
s = s - box_from_corners([-box_w / 2.0 + 10.0, box_d / 2.0 - 1.5, -1.0], [box_w / 2.0 - 10.0, box_d / 2.0 + 1.5, t + 1.0]);
s - cylinder([0, -t - 1.0, height - 12.0], "Y", 2.25, t + 2.0)
