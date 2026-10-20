// Car battery positive terminal cover boot: 45 x 30 x 32 mm, 2 mm wall, 6 mm corner radius, 14 mm cable entry, raised "+" mark on top
let length = 45.0; // [35.0, 65.0] Length (mm)
let width = 30.0; // [24.0, 45.0] Width (mm)
let height = 32.0; // [24.0, 45.0] Height (mm)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
let cable_d = 14.0; // [8.0, 20.0] Cable entry diameter (mm)
const corner_r = 6.0;
const top_r = 4.0;
let outer = box_centered(length, width, height).translate([0, 0, height / 2.0]).fillet(corner_r, "|Z").fillet(top_r, ">Z");
let inner = box_centered(length - 2.0 * wall, width - 2.0 * wall, height).translate([0, 0, height / 2.0 - wall - 1.0])
    .fillet(corner_r - wall, "|Z").fillet(top_r - wall, ">Z");
let cover = outer - inner;
let cd = min(cable_d, width - 8.0);
cover = cover - cylinder([0, 0, cd / 2.0 + 2.0], "X", cd / 2.0, length) - box_centered(length, cd, cd / 2.0 + 2.1).translate([length / 2.0, 0, (cd / 2.0 + 2.0) / 2.0 - 0.05]);
let plus = box_centered(12.0, 3.0, 1.2) + box_centered(3.0, 12.0, 1.2);
cover + plus.translate([-length * 0.12, 0, height + 0.5])
