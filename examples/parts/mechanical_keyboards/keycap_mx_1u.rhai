// 1u keycap for MX-style switches: 18 x 18 mm base tapering to 12.5 mm, 7.5 mm tall with a 1 mm dished top, 1.2 mm walls and a cross stem (4.1 x 1.25 mm arms) in a 5.5 mm boss
let base = 18.0; // [17.5, 18.5] Base size (mm)
let height = 7.5; // [6.0, 12.0] Cap height (mm)
let top = 12.5; // [11.0, 14.5] Top size (mm)
const wall = 1.2;
let outer = loft([rect(plane([0, 0, 0], [0, 0, 1]), base, base), rect(plane([0, 0, height], [0, 0, 1]), top, top)], true);
let inner = loft([rect(plane([0, 0, -0.01], [0, 0, 1]), base - 2.0 * wall, base - 2.0 * wall), rect(plane([0, 0, height - wall], [0, 0, 1]), top - 2.0 * wall, top - 2.0 * wall)], true);
let dish = sphere([0, 0, height + 40.0 - 1.0], 40.0);
let boss = cylinder([0, 0, 0.5], "Z", 2.75, height - wall);
let cross = box_centered(4.1, 1.25, 10.0).translate([0, 0, 0.5]) + box_centered(1.25, 4.1, 10.0).translate([0, 0, 0.5]);
outer - inner - dish + (boss - cross)
