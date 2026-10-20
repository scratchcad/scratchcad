// Terminal block marker strip: 10 markers 5.1 x 10 mm on a 51 mm carrier 0.8 mm, 0.4 mm break notches
let n = 10; // [5, 20] Number of markers
let pitch = 5.1; // [5.0, 10.2] Marker pitch (mm)
let height = 10.0; // [6.0, 15.0] Marker height (mm)
let t = 0.8; // [0.5, 1.5] Thickness (mm)
let strip = box_from_corners([0, 0, 0], [n.to_float() * pitch, height, t]);
let notches = [];
for i in 1..n { notches.push(box_from_corners([i.to_float() * pitch - 0.2, -1, t - 0.4], [i.to_float() * pitch + 0.2, height + 1.0, t + 1.0])); }
let pegs = [];
for i in 0..n { pegs.push(box_from_corners([i.to_float() * pitch + 1.5, height / 2.0 - 1.0, -2.0], [i.to_float() * pitch + pitch - 1.5, height / 2.0 + 1.0, 0.01])); }
strip - compound(notches) + compound(pegs)
