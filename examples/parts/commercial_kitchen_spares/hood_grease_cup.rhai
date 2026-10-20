// Extraction hood grease cup: slide-in drip cup 100 x 60 x 40 mm with 1.5 mm walls and an 8 mm flange along both long sides to run in the hood's rails, plus a 20 x 10 mm pull tab
let length = 100.0; // [70.0, 150.0] Cup length (mm)
let width = 60.0; // [40.0, 80.0] Cup width (mm)
let depth = 40.0; // [25.0, 60.0] Cup depth (mm)
const wall = 1.5;
const flange = 8.0;
let cup = box_from_corners([0, -width / 2.0, -depth], [length, width / 2.0, 0]).shell(-wall, ">Z");
let rails = box_from_corners([0, -width / 2.0 - flange, -wall], [length, -width / 2.0 + 0.5, 0]) + box_from_corners([0, width / 2.0 - 0.5, -wall], [length, width / 2.0 + flange, 0]);
let tab = box_from_corners([-20.0, -10.0, -wall], [0.5, 10.0, 0]);
cup + rails + tab - cylinder([-10.0, 0, -wall - 1.0], "Z", 3.0, wall + 2.0)
