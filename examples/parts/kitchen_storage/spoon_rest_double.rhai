// Double spoon rest: 230 x 100 mm, two 70 mm bowls 12 mm deep, 30 mm handle cradles, 4 mm floor
let length = 230.0; // [180.0, 300.0] Length (mm)
let width = 100.0; // [80.0, 130.0] Width (mm)
let height = 16.0; // [10.0, 25.0] Height (mm)
let base = box_centered(length, width, height).translate([0, 0, height / 2.0]);
let b = base.fillet(width / 2.0 - 1.0, base.edges("|Z"));
let bowls = [];
for x in [-length / 4.0 + 10.0, length / 4.0 - 10.0] { bowls.push(sphere([x, -width * 0.12, height + 50.0 - 12.0], 50.0)); }
let cradle = cylinder([-length, width * 0.32, height + 10.0], "X", 13.0, length * 2.0);
b - fuse_all(bowls) - cradle
