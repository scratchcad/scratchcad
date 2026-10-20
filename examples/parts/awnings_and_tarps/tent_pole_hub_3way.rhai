// Tent pole hub, 3-way: 9.5 mm pole sockets 25 mm deep at 120 degrees and 20 degrees down, 30 mm centre boss
let pole = 9.5; // [7.0, 13.0] Pole diameter (mm)
let depth = 25.0; // [15.0, 35.0] Socket depth (mm)
let droop = 20.0; // [0.0, 40.0] Socket droop (degrees)
let boss = cylinder([0, 0, -8.0], "Z", 15.0, 16.0);
let socks = [];
let holes = [];
for k in 0..3 {
    socks.push(cylinder([0, 0, 0], "X", pole / 2.0 + 2.5, depth + 12.0).rotate_y(droop).rotate_z(k.to_float() * 120.0));
    holes.push(cylinder([12.0, 0, 0], "X", pole / 2.0 + 0.2, depth + 2.0).rotate_y(droop).rotate_z(k.to_float() * 120.0));
}
boss + fuse_all(socks) - fuse_all(holes)
