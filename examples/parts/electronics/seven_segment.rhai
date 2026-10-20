// 0.56 in single-digit 7-segment display: 12.6 x 19 x 8 mm body, 7 slanted segments and a decimal point, 10 pins
let width = 12.6; // [10.0, 20.0] Width (mm)
let height = 19.0; // [15.0, 30.0] Height (mm)
let depth = 8.0; // [6.0, 12.0] Depth (mm)
let body = box_centered(width, height, depth).translate([0, 0, depth / 2.0]);
let seg_l = height * 0.35; let seg_w = 1.4;
let segs = [];
for y in [-height * 0.38, 0.0, height * 0.38] { segs.push(box_centered(seg_l * 0.8, seg_w, 0.6).translate([0, y, depth])); }
for sx in [-1, 1] { for sy in [-1, 1] { segs.push(box_centered(seg_w, seg_l * 0.85, 0.6).translate([sx * seg_l * 0.45, sy * height * 0.19, depth])); } }
segs.push(cylinder([width / 2.0 - 1.5, -height * 0.4, depth - 0.3], "Z", 0.7, 0.6));
let pins = [];
for i in 0..5 { for s in [-1, 1] { pins.push(box_centered(0.5, 0.25, 6.0).translate([-5.08 + i.to_float() * 2.54, s * 7.62, -3.0])); } }
fuse_all([body] + pins) - compound(segs)
