// M18 proximity sensor angle bracket: 40 x 30 mm L, 3 mm, 18.5 mm sensor hole, 2 x 6.5 mm slotted mounting holes
let width = 30.0; // [20.0, 45.0] Bracket width (mm)
let leg = 40.0; // [30.0, 60.0] Leg length (mm)
let t = 3.0; // [2.0, 5.0] Thickness (mm)
let sensor = 18.5; // [12.5, 30.5] Sensor hole (mm)
let a = box_from_corners([0, 0, 0], [width, leg, t]);
let b = box_from_corners([0, 0, 0], [width, t, leg]);
let slots = [];
for x in [width * 0.25, width * 0.75] { slots.push(cylinder([x, 15.0, -1], "Z", 3.25, t + 2.0) + box_from_corners([x - 3.25, 15.0, -1], [x + 3.25, 25.0, t + 1.0]) + cylinder([x, 25.0, -1], "Z", 3.25, t + 2.0)); }
a + b - fuse_all(slots) - cylinder([width / 2.0, -1, leg * 0.6], "Y", sensor / 2.0, t + 2.0)
