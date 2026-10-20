// Wall J-hook with hardened-pin holes: 30 x 15 mm plate 3 mm thick with two 1.2 mm pin holes angled 45 degrees down, and a 12 mm wide J hook 15 mm deep
let width = 15.0; // [10.0, 25.0] Hook width (mm)
let depth = 15.0; // [8.0, 25.0] Hook depth (mm)
const t = 3.0;
let plate = box_from_corners([0, 0, 0], [width, t, 30.0]);
let arm = box_from_corners([0, -depth, 0], [width, t, t]);
let lip = box_from_corners([0, -depth, 0], [width, -depth + t, 8.0]);
let pins = [];
for x in [width * 0.3, width * 0.7] { pins.push(cylinder([0, 0, 0], "Y", 0.6, 20.0).rotate_x(-45.0).translate([x, -5.0, 27.0])); }
plate + arm + lip - fuse_all(pins)
