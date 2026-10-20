// Desk organizer tray: 200 x 100 x 40 mm, 2 mm walls, three compartments of 50 / 70 / 80 mm, finger scoop
let length = 200.0; // [140.0, 300.0] Length (mm)
let width = 100.0; // [60.0, 160.0] Width (mm)
let height = 40.0; // [20.0, 80.0] Height (mm)
let wall = 2.0; // [1.2, 4.0] Wall thickness (mm)
let tray = box(length, width, height).fillet(6.0, "|Z").shell(-wall, ">Z");
let dividers = [];
for x in [50.0, 120.0] { dividers.push(box_from_corners([x, wall - 0.1, wall - 0.1], [x + wall, width - wall + 0.1, height * 0.8])); }
let scoop = cylinder([length + 1, width / 2.0, height], "X", 15.0, 50.0).translate([-50.0 - 2.0, 0, 0]);
fuse_all([tray] + dividers) - cylinder([-1, width / 2.0, height + 8.0], "X", 18.0, 2.0 * wall + 2.0)
