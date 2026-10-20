// Snap-in knockout seal for a 7/8 in (22.2 mm) electrical box knockout: 28 mm cap 1.5 mm thick, six spring fingers with locking hooks for 1-2 mm sheet
let ko_d = 22.2; // [12.7, 35.0] Knockout diameter (mm)
let cap_d = 28.0; // [16.0, 45.0] Cap diameter (mm)
let fingers = 6; // [3, 10] Number of fingers
let sheet = 1.6; // [0.8, 2.5] Box wall thickness (mm)
let rk = ko_d / 2.0;
let cap = cylinder(max(cap_d / 2.0, rk + 2.0), 1.5).chamfer(0.6, ">Z");
let ring = cylinder([0, 0, -6.0], "Z", rk - 0.3, 6.01) - cylinder([0, 0, -7.0], "Z", rk - 1.5, 8.0);
let hooks = (cone(rk - 0.3, rk + 0.8, 1.5).translate([0, 0, -sheet - 1.5]) + cone(rk + 0.8, rk - 0.3, 2.0).translate([0, 0, -sheet - 3.5])) - cylinder([0, 0, -8.0], "Z", rk - 1.5, 9.0);
let body = fuse_all([cap, ring, hooks]);
let slots = [];
for i in 0..fingers { slots.push(box_centered(1.2, rk + 3.0, 7.0).translate([0, rk / 2.0 + 1.0, -3.6]).rotate_z(i.to_float() * 360.0 / fingers.to_float())); }
body - fuse_all(slots)
