// Incense stick holder boat: 250 x 30 x 15 mm ash catcher, 1.5 mm hole raised 20 degrees at one end
let length = 250.0; // [150.0, 300.0] Length (mm)
let width = 30.0; // [20.0, 50.0] Width (mm)
let height = 15.0; // [8.0, 25.0] Height (mm)
let wall = 2.5; // [2.0, 4.0] Wall (mm)
let tray = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, height]);
let t = tray.fillet(width / 2.0 - 0.5, tray.edges("|Z"));
let hollow = box_from_corners([wall, -width / 2.0 + wall, wall], [length - wall, width / 2.0 - wall, height + 1.0]);
let h = hollow.fillet(width / 2.0 - wall - 0.5, hollow.edges("|Z"));
let boss = cylinder([18.0, 0, wall - 0.01], "Z", 6.0, 8.0);
t - h + boss - cylinder([18.0, 0, 3.0], "Z", 0.9, 20.0).rotate([18.0, 0, 3.0], "Y", 20.0)
