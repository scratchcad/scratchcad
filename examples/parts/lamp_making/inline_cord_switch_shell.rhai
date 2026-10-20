// Inline cord switch shell half: 60 x 22 x 12 mm half shell, 2 mm walls, two 6 mm cord entries at the ends, a 10 x 6 mm rocker opening and two 3 mm screw bosses
let length = 60.0; // [45.0, 80.0] Shell length (mm)
let cord = 6.0; // [4.0, 8.0] Cord diameter (mm)
const w = 22.0;
const h = 12.0;
const wall = 2.0;
let s = box_centered(length, w, h).translate([0, 0, h / 2.0]);
let s = s.fillet(4.0, s.edges("|Z"));
let s = s - box_centered(length - 2.0 * wall, w - 2.0 * wall, h).translate([0, 0, h / 2.0 + wall]);
let bosses = cylinder([-length / 2.0 + 10.0, 0, wall - 0.01], "Z", 3.0, h - wall) + cylinder([length / 2.0 - 10.0, 0, wall - 0.01], "Z", 3.0, h - wall);
s + bosses - cylinder([-length, 0, h], "X", cord / 2.0, 2.0 * length) - box_centered(10.0, 6.0, wall + 2.0).translate([0, 0, wall / 2.0]) - cylinder([-length / 2.0 + 10.0, 0, -1.0], "Z", 1.25, h + 2.0) - cylinder([length / 2.0 - 10.0, 0, -1.0], "Z", 1.25, h + 2.0)
