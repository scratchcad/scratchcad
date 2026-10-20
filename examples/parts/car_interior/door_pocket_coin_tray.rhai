// Door pocket coin tray insert: 120 x 60 x 25 mm, 3 coin slots 26 mm wide, 2 mm walls, rubber base recess
let length = 120.0; // [80.0, 180.0] Length (mm)
let width = 60.0; // [40.0, 90.0] Width (mm)
let height = 25.0; // [15.0, 40.0] Height (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let tray = box_from_corners([0, 0, 0], [length, width, height]);
let t = tray.fillet(8.0, tray.edges("|Z"));
let slots = [];
for k in 0..3 { let x0 = wall + k.to_float() * (length - wall) / 3.0; let c = box_from_corners([x0, wall, wall], [x0 + (length - wall) / 3.0 - wall, width - wall, height + 1.0]); slots.push(c.fillet(6.0, c.edges("|Z"))); }
t - fuse_all(slots) - box_from_corners([10.0, 10.0, -1], [length - 10.0, width - 10.0, 0.8])
