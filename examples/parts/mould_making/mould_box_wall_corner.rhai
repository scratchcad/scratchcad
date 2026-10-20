// Adjustable silicone mould box wall: 100 x 60 mm wall 4 mm thick with an interlocking 4 mm slot at one end and a 4 mm tongue at the other, so four walls clip into any rectangle
let length = 100.0; // [60.0, 200.0] Wall length (mm)
let height = 60.0; // [30.0, 120.0] Wall height (mm)
const t = 4.0;
let w = box_from_corners([0, 0, 0], [length, t, height]);
let tongue = box_from_corners([length - 0.01, 0, 0], [length + 8.0, t, height]) - box_from_corners([length + 4.0, -1.0, -1.0], [length + 9.0, t + 1.0, height + 1.0]);
let slot_block = box_from_corners([-12.0, -4.0, 0], [0.01, t + 4.0, height]) - box_from_corners([-8.0, 0, -1.0], [-4.0 + 0.2, t + 0.2, height + 1.0]);
w + tongue + slot_block
