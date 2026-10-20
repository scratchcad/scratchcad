// Fruit picker basket head: 110 mm cup 100 mm deep with 2.5 mm walls, 8 picking fingers 30 mm tall around the rim, 15 mm drain holes and a 25 mm pole socket 60 mm deep angled 30 degrees
let cup = 110.0; // [80.0, 150.0] Basket diameter (mm)
let depth = 100.0; // [70.0, 140.0] Basket depth (mm)
let pole = 25.0; // [20.0, 32.0] Pole diameter (mm)
const wall = 2.5;
let r = cup / 2.0;
let basket = cylinder([0, 0, 0], "Z", r, depth) - cylinder([0, 0, wall], "Z", r - wall, depth);
let fingers = [];
for i in 0..8 { fingers.push(box_from_corners([r - wall, -4.0, depth - 0.01], [r, 4.0, depth + 30.0]).rotate_z(i.to_float() * 45.0)); }
let drains = [];
for i in 0..4 { drains.push(cylinder([r * 0.5, 0, -1.0], "Z", 7.5, wall + 2.0).rotate_z(i.to_float() * 90.0 + 45.0)); }
let socket = (cylinder([0, 0, 0], "Z", pole / 2.0 + 3.0, 60.0) - cylinder([0, 0, -1.0], "Z", pole / 2.0, 60.0)).rotate_x(150.0).translate([0, -r + 10.0, depth * 0.4]);
basket + fuse_all(fingers) + socket - fuse_all(drains)
