// Slide staining rack: 10 slides in a 90 x 40 x 70 mm open frame, 1.5 mm slots on 7 mm pitch, wire-style handle 3 mm
let n = 10; // [5, 20] Number of slides
let pitch = 7.0; // [5.0, 10.0] Slot pitch (mm)
let length = n.to_float() * pitch + 12.0;
let frame = box_from_corners([0, 0, 0], [length, 40.0, 4.0]) + box_from_corners([0, 0, 0], [length, 4.0, 60.0]) + box_from_corners([0, 36.0, 0], [length, 40.0, 60.0]);
let window = box_from_corners([6.0, 8.0, -1], [length - 6.0, 32.0, 5.0]);
let slots = [];
for i in 0..n { let x = 6.0 + pitch / 2.0 + i.to_float() * pitch; slots.push(box_from_corners([x - 0.75, -1, 6.0], [x + 0.75, 3.0, 61.0]) + box_from_corners([x - 0.75, 37.0, 6.0], [x + 0.75, 41.0, 61.0]) + box_from_corners([x - 0.75, 4.0, 2.5], [x + 0.75, 36.0, 5.0])); }
let handle = box_from_corners([length / 2.0 - 1.5, 2.0, 59.99], [length / 2.0 + 1.5, 38.0, 63.0]) + box_from_corners([length / 2.0 - 1.5, 18.0, 62.99], [length / 2.0 + 1.5, 22.0, 75.0]) + box_from_corners([length / 2.0 - 1.5, 12.0, 74.99], [length / 2.0 + 1.5, 28.0, 78.0]);
frame - window - fuse_all(slots) + handle
