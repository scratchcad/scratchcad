// Castellated frame spacer for 10 frames: 380 x 25 mm strip 2 mm, 10 slots 2 mm wide at 35 mm centers 12 mm deep
let frames = 10; // [5, 12] Number of frames
let pitch = 35.0; // [32.0, 38.0] Frame spacing (mm)
let height = 25.0; // [15.0, 35.0] Strip height (mm)
let t = 2.0; // [1.0, 3.0] Strip thickness (mm)
let length = frames.to_float() * pitch + 30.0;
let strip = box_from_corners([0, 0, 0], [length, t, height]);
let slots = [];
for i in 0..frames { let x = 15.0 + pitch / 2.0 + i.to_float() * pitch; slots.push(box_from_corners([x - 1.5, -1, height - 12.0], [x + 1.5, t + 1.0, height + 1.0]) + cylinder([x, -1, height - 12.0], "Y", 1.5, t + 2.0)); }
let tabs = box_from_corners([0, 0, 0], [5.0, 10.0, t]) + box_from_corners([length - 5.0, 0, 0], [length, 10.0, t]);
strip - fuse_all(slots) + tabs - cylinder([2.5, 6.0, -1], "Z", 1.0, 5.0) - cylinder([length - 2.5, 6.0, -1], "Z", 1.0, 5.0)
