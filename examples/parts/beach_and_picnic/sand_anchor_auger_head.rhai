// Beach umbrella sand anchor head: 40 mm socket 60 mm deep for a 32 mm pole, 3 mm walls, a 12 mm T-handle bar across the base for twisting it in and a 12 mm thumbscrew boss
let pole = 32.0; // [22.0, 40.0] Pole diameter (mm)
let depth = 60.0; // [40.0, 90.0] Socket depth (mm)
const wall = 3.0;
let r = pole / 2.0 + 0.4;
let s = cylinder([0, 0, 0], "Z", r + wall, depth) - cylinder([0, 0, wall], "Z", r, depth);
let handle = cylinder([-r - wall - 40.0, 0, 8.0], "X", 6.0, 2.0 * (r + wall + 40.0));
let boss = cylinder([r + wall - 1.0, 0, depth - 15.0], "X", 6.0, 10.0);
s + handle + boss - cylinder([r - 1.0, 0, depth - 15.0], "X", 3.0, 15.0)
