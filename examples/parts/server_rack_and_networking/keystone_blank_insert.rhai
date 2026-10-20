// Keystone blank insert: 14.5 x 16 mm face 2 mm thick over a 14.9 x 19.3 mm body 20 mm deep, 1.2 mm walls, with a 1 mm latch tab and a 2 mm rear hook
let depth = 20.0; // [15.0, 28.0] Body depth (mm)
let face_w = 14.5; // [14.0, 15.5] Face width (mm)
const wall = 1.2;
let face_ = box_centered(face_w, 16.0, 2.0).translate([0, 0, 1.0]);
let body = box_centered(14.9, 19.3, depth).translate([0, 0, -depth / 2.0 + 0.01]) - box_centered(14.9 - 2.0 * wall, 19.3 - 2.0 * wall, depth).translate([0, 0, -depth / 2.0 - 1.0]);
let tab = box_from_corners([-4.0, 19.3 / 2.0 - 0.01, -8.0], [4.0, 19.3 / 2.0 + 1.0, -3.0]);
let hook = box_from_corners([-4.0, -19.3 / 2.0 - 2.0, -depth], [4.0, -19.3 / 2.0 + 0.01, -depth + 2.0]);
face_ + body + tab + hook
