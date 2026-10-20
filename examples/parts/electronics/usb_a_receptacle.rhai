// USB-A receptacle: 14.5 x 7.0 mm steel shell 13.7 mm deep, 0.3 mm walls, plastic tongue 11 x 1.8 mm, two mounting tabs
let width = 14.5; // [12.0, 16.0] Shell width (mm)
let height = 7.0; // [5.5, 8.0] Shell height (mm)
let depth = 13.7; // [10.0, 17.0] Depth (mm)
let wall = 0.3; // [0.2, 0.6] Shell wall (mm)
let shell = box_centered(width, depth, height).translate([0, 0, height / 2.0]) - box_centered(width - 2.0 * wall, depth + 2.0, height - 2.0 * wall).translate([0, -wall - 1.0, height / 2.0]);
shell = shell + box_centered(width - 2.0 * wall, wall, height - 2.0 * wall).translate([0, depth / 2.0 - wall / 2.0, height / 2.0]);
let tongue = box_centered(11.0, depth - 2.0, 1.8).translate([0, 1.0, height * 0.62]);
let tabs = box_centered(1.0, 0.3, 3.0).translate([-width / 2.0 + 0.5, 2.0, -1.5]) + box_centered(1.0, 0.3, 3.0).translate([width / 2.0 - 0.5, 2.0, -1.5]);
fuse_all([shell, tongue, tabs])
