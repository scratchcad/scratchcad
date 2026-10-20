// BNC female dust cap: 12 mm ID push-on cap 12 mm tall, 1.2 mm wall, 2 bayonet slot clearances, tether loop
let id = 9.7; // [9.0, 12.0] Connector OD (mm)
let height = 12.0; // [8.0, 16.0] Cap height (mm)
let wall = 1.2; // [0.8, 2.0] Wall (mm)
let cap = cylinder(id / 2.0 + wall, height) - cylinder([0, 0, -1], "Z", id / 2.0, height);
let loop_ = cylinder([id / 2.0 + wall + 2.0, -1.0, height - 3.0], "Y", 3.0, 2.0) - cylinder([id / 2.0 + wall + 2.0, -1.5, height - 3.0], "Y", 1.5, 3.0);
cap + loop_ - box_from_corners([-1.0, -id, -1], [1.0, id, 3.0])
