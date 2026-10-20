// Microscope slide box: 25 slots for 75 x 25 mm slides, 1.5 mm slot pitch 3.5 mm, 100 x 33 x 85 mm body, 2 mm walls
let slots = 25; // [10, 50] Number of slides
let pitch = 3.5; // [3.0, 5.0] Slot pitch (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let length = slots.to_float() * pitch + 2.0 * wall + 3.0;
let body = box_from_corners([0, 0, 0], [length, 33.0, 30.0]);
let cavity = box_from_corners([wall, wall, wall], [length - wall, 33.0 - wall, 31.0]);
let ribs = [];
for i in 0..=slots { let x = wall + 1.5 + i.to_float() * pitch - 1.0; ribs.push(box_from_corners([x, wall - 0.01, wall - 0.01], [x + 1.0, 4.5, 26.0]) + box_from_corners([x, 33.0 - 4.5, wall - 0.01], [x + 1.0, 33.0 - wall + 0.01, 26.0])); }
body - cavity + compound(ribs)
