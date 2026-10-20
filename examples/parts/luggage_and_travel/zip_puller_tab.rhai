// Zip puller tab: 35 x 12 mm grip tab 3 mm thick with a 5 mm cord hole, a 4 x 2 mm slot for the slider pull ring and 1 mm grip grooves
let length = 35.0; // [25.0, 50.0] Tab length (mm)
let width = 12.0; // [8.0, 16.0] Tab width (mm)
const t = 3.0;
let tab = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, t]) + cylinder([length, 0, 0], "Z", width / 2.0, t);
let grooves = [];
for i in 0..4 { grooves.push(box_from_corners([10.0 + i.to_float() * 4.0, -width, t - 0.6], [11.0 + i.to_float() * 4.0, width, t + 1.0])); }
tab - fuse_all(grooves) - cylinder([length, 0, -1.0], "Z", 2.5, t + 2.0) - box_from_corners([2.0, -2.0, -1.0], [4.0, 2.0, t + 1.0])
