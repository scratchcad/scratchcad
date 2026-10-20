// E-bike controller enclosure: 110 x 60 x 35 mm, 2 mm wall, 12 heatsink fins on top, 2 PG7 glands 12.5 mm on one end
let length = 110.0; // [80.0, 160.0] Length (mm)
let width = 60.0; // [40.0, 90.0] Width (mm)
let height = 35.0; // [25.0, 50.0] Height (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let outer = box_from_corners([0, 0, 0], [length, width, height]);
let o = outer.fillet(4.0, outer.edges("|Z"));
let inner = box_from_corners([wall, wall, -1], [length - wall, width - wall, height - wall]);
let fins = [];
for k in 0..12 { fins.push(box_from_corners([8.0, 4.0 + k.to_float() * 4.5, height - 0.01], [length - 8.0, 5.5 + k.to_float() * 4.5, height + 8.0])); }
let glands = cylinder([-1, width / 3.0, height / 2.0], "X", 6.25, wall + 2.0) + cylinder([-1, 2.0 * width / 3.0, height / 2.0], "X", 6.25, wall + 2.0);
o - inner + fuse_all(fins) - glands
