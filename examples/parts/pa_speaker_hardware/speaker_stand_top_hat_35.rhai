// Speaker stand top hat socket: 35 mm pole socket 80 mm deep, 3 mm walls, on a 120 mm round flange 6 mm thick with four 6.5 mm bolt holes on a 90 mm PCD and an M8 locking boss
let pole = 35.0; // [32.0, 40.0] Pole diameter (mm)
let depth = 80.0; // [50.0, 110.0] Socket depth (mm)
const wall = 3.0;
let r = pole / 2.0 + 0.3;
let flange = cylinder([0, 0, 0], "Z", 60.0, 6.0);
let socket = cylinder([0, 0, -depth], "Z", r + wall, depth + 0.01) - cylinder([0, 0, -depth - 1.0], "Z", r, depth + 1.0 - wall);
let boss = cylinder([r + wall - 1.0, 0, -depth + 20.0], "X", 7.0, 12.0) - cylinder([r - 1.0, 0, -depth + 20.0], "X", 3.4, 20.0);
let holes = [];
for i in 0..4 { let a = (45.0 + 90.0 * i.to_float()) * PI() / 180.0; holes.push(cylinder([45.0 * cos(a), 45.0 * sin(a), -1.0], "Z", 3.25, 8.0)); }
flange + socket + boss - fuse_all(holes) - cylinder([r - 1.0, 0, -depth + 20.0], "X", 3.4, 20.0)
