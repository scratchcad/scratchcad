// Practice green hole cup: 108 mm (4.25 inch) ID, 102 mm deep, 3 mm wall with a 5 mm bottom, a 20 mm flagstick ferrule socket 25 mm deep and four 10 mm drain holes
let id = 108.0; // [100.0, 115.0] Cup inside diameter (mm)
let depth = 102.0; // [90.0, 150.0] Cup depth (mm)
const wall = 3.0;
const floor_t = 5.0;
let cup = cylinder([0, 0, 0], "Z", id / 2.0 + wall, depth + floor_t) - cylinder([0, 0, floor_t], "Z", id / 2.0, depth + 1.0);
let socket = cylinder([0, 0, floor_t - 0.01], "Z", 16.0, 25.0) - cylinder([0, 0, floor_t], "Z", 10.0, 30.0);
let drains = [];
for i in 0..4 { let a = (45.0 + 90.0 * i.to_float()) * PI() / 180.0; drains.push(cylinder([id * 0.33 * cos(a), id * 0.33 * sin(a), -1.0], "Z", 5.0, floor_t + 2.0)); }
cup + socket - fuse_all(drains)
