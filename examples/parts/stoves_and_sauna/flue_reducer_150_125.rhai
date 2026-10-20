// Flue pipe reducer 150 to 125 mm: 2 mm wall, 40 mm 150 mm socket, 60 mm taper and 40 mm 125 mm spigot
let big = 150.0; // [120.0, 200.0] Large socket ID (mm)
let small = 125.0; // [80.0, 150.0] Small spigot OD (mm)
const wall = 2.0;
const sock = 40.0;
let outer = cylinder([0, 0, 0], "Z", big / 2.0 + wall, sock + 0.01) + cone(big / 2.0 + wall, small / 2.0, 60.0).translate([0, 0, sock]) + cylinder([0, 0, sock + 59.99], "Z", small / 2.0, 40.0);
let inner = cylinder([0, 0, -1.0], "Z", big / 2.0, sock + 1.01) + cone(big / 2.0, small / 2.0 - wall, 60.0).translate([0, 0, sock]) + cylinder([0, 0, sock + 59.99], "Z", small / 2.0 - wall, 41.0);
outer - inner
