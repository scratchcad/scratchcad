// Sauna ladle head: 80 mm hemispherical bowl with 3 mm wall and a 20 mm handle socket angled 30 degrees with a 3.5 mm pin hole
let bowl = 80.0; // [60.0, 110.0] Bowl diameter (mm)
let socket = 20.0; // [16.0, 26.0] Handle socket diameter (mm)
const wall = 3.0;
let r = bowl / 2.0;
let cup = (sphere([0, 0, 0], r) - sphere([0, 0, 0], r - wall)) - box_centered(3.0 * r, 3.0 * r, 2.0 * r).translate([0, 0, r]);
let boss = cylinder([0, 0, 0], "Z", socket / 2.0 + 3.0, 40.0).rotate_y(60.0).translate([r - 6.0, 0, -6.0]);
let hole = cylinder([0, 0, 8.0], "Z", socket / 2.0, 40.0).rotate_y(60.0).translate([r - 6.0, 0, -6.0]);
let pin = cylinder([0, 0, 25.0], "Y", 1.75, 0.0 + 4.0 * socket).translate([0, -2.0 * socket, 0]).rotate_y(60.0).translate([r - 6.0, 0, -6.0]);
cup + boss - sphere([0, 0, 0], r - wall) - hole - pin
