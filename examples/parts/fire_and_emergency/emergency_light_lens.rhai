// Emergency exit light diffuser lens: 300 x 110 mm, 25 mm tall rounded profile, 1.5 mm wall, 4 snap tabs
let length = 300.0; // [200.0, 400.0] Length (mm)
let width = 110.0; // [80.0, 150.0] Width (mm)
let height = 25.0; // [15.0, 40.0] Height (mm)
let wall = 1.5; // [1.0, 2.5] Wall (mm)
let outer = box_centered(length, width, height).translate([0, 0, height / 2.0]);
let o = outer.fillet(height - 1.0, outer.edges(">Z and |X"));
let inner = box_centered(length - 2.0 * wall, width - 2.0 * wall, height).translate([0, 0, height / 2.0 - wall]);
let i = inner.fillet(height - 1.0 - wall, inner.edges(">Z and |X"));
let tabs = [];
for x in [-length / 3.0, length / 3.0] { for s in [-1.0, 1.0] { tabs.push(box_centered(12.0, wall, 8.0).translate([x, s * (width / 2.0 - wall * 1.5), -3.99]) + box_centered(12.0, 2.0, 1.5).translate([x, s * (width / 2.0 - wall * 2.0 - 0.5), -7.0])); } }
o - i + fuse_all(tabs)
