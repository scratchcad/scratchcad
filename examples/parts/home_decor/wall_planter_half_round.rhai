// Wall-hung half-round planter: 160 mm wide, 120 mm tall, 80 mm deep, 3 mm wall, keyhole slot, drain hole
let width = 160.0; // [100.0, 250.0] Width (mm)
let height = 120.0; // [80.0, 200.0] Height (mm)
let wall = 3.0; // [2.0, 5.0] Wall (mm)
let r = width / 2.0;
let pot = cylinder(r, height) & box_from_corners([-r, 0, 0], [r, r, height]);
let back = box_from_corners([-r, -0.01, 0], [r, wall, height + 20.0]);
let cavity = cylinder([0, 0, wall], "Z", r - wall, height) & box_from_corners([-r, wall, wall], [r, r, height + 1.0]);
let key = cylinder([0, -1, height + 8.0], "Y", 4.5, wall + 2.0) + box_from_corners([-2.5, -1, height + 8.0], [2.5, wall + 1.0, height + 15.0]);
let kh = key + cylinder([0, -1, height + 15.0], "Y", 2.5, wall + 2.0);
pot + back - cavity - kh - cylinder([0, r * 0.4, -1], "Z", 5.0, wall + 2.0)
