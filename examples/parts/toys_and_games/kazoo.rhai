// Kazoo: 100 mm tapered body from 22 to 15 mm, 1.5 mm wall, 14 mm membrane turret with a vented cap
let len = 100.0; // [80.0, 140.0] Length (mm)
let body = cone(11.0, 7.5, len).rotate_y(90.0) - cone(9.5, 6.0, len + 0.1).rotate_y(90.0).translate([-0.05, 0, 0]);
let turret = cylinder([len * 0.6, 0, 0], "Z", 7.0, 13.0) - cylinder([len * 0.6, 0, 0], "Z", 5.5, 14.0);
let cap = cylinder([len * 0.6, 0, 12.9], "Z", 8.0, 2.0) - cylinder([len * 0.6, 0, 12.0], "Z", 3.0, 4.0);
fuse_all([body, turret, cap])
