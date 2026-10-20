// Architectural model scale bar 1:100: 110 x 12 mm bar 2 mm thick with alternating 10 mm blocks raised 0.6 mm (each 1 m) and 5 mm clear ends
let units = 10; // [5, 20] Number of 1 m divisions
let unit = 10.0; // [5.0, 20.0] Model length of one division (mm)
let length = units.to_float() * unit + 10.0;
let bar = box_from_corners([0, 0, 0], [length, 12.0, 2.0]);
let blocks = [];
for i in 0..units { if i % 2 == 0 { blocks.push(box_from_corners([5.0 + i.to_float() * unit, 2.0, 1.99], [5.0 + (i + 1).to_float() * unit, 10.0, 2.6])); } }
bar + fuse_all(blocks)
