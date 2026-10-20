// Flat-face quick coupler dust cap: 40 mm cap 25 mm deep with 2 mm walls for a 1/2 inch flat-face coupler (36 mm), a 6 mm tether loop and 4 internal retaining bumps
let coupler = 36.0; // [24.0, 50.0] Coupler body OD (mm)
let depth = 25.0; // [15.0, 35.0] Cap depth (mm)
const wall = 2.0;
let r = coupler / 2.0 + 0.4;
let c = cylinder([0, 0, 0], "Z", r + wall, depth + wall) - cylinder([0, 0, -1.0], "Z", r, depth + 1.0);
let bumps = [];
for i in 0..4 { bumps.push(sphere([r, 0, 6.0], 1.0).rotate_z(i.to_float() * 90.0)); }
let tether = cylinder([r + wall + 4.0, 0, depth + wall - 3.0], "Z", 5.0, 3.0) - cylinder([r + wall + 4.0, 0, depth + wall - 4.0], "Z", 3.0, 5.0) + box_from_corners([r + wall - 1.0, -3.0, depth + wall - 3.0], [r + wall + 1.0, 3.0, depth + wall]);
c + fuse_all(bumps) + tether
