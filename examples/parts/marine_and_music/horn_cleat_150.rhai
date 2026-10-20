// 150 mm horn cleat: two tapered horns 20 mm tall on two 22 mm feet with 6.5 mm bolt holes 90 mm apart
let len = 150.0; // [100.0, 250.0] Length (mm)
let h = 32.0; // [24.0, 50.0] Height (mm)
let s = len / 150.0;
let horn = loft([circle([-len / 2.0, 0, h - 6.0 * s], [1, 0, 0], 4.0 * s), circle([-len / 4.0, 0, h - 8.0 * s], [1, 0, 0], 7.0 * s), circle([0, 0, h - 9.0 * s], [1, 0, 0], 8.0 * s), circle([len / 4.0, 0, h - 8.0 * s], [1, 0, 0], 7.0 * s), circle([len / 2.0, 0, h - 6.0 * s], [1, 0, 0], 4.0 * s)], true);
let feet = [];
for x in [-45.0 * s, 45.0 * s] { feet.push(loft([rect(plane([x, 0, 0], "Z"), 22.0 * s, 18.0 * s), rect(plane([x, 0, h - 10.0 * s], "Z"), 12.0 * s, 10.0 * s)], true)); }
let cleat = fuse_all([horn] + feet);
for x in [-45.0 * s, 45.0 * s] { cleat -= cylinder([x, 0, -1], "Z", 3.25, 12.0); }
cleat
