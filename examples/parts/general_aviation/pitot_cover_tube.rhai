// Pitot tube cover: 12 mm bore 60 mm long, 1.5 mm wall, closed rounded end, 8 mm streamer loop
let bore = 12.0; // [8.0, 20.0] Pitot diameter (mm)
let length = 60.0; // [40.0, 90.0] Cover length (mm)
let wall = 1.5; // [1.0, 2.5] Wall (mm)
let r = bore / 2.0 + wall;
let c = cylinder(r, length) + sphere([0, 0, length], r) - cylinder([0, 0, -1], "Z", bore / 2.0, length + 1.0) - sphere([0, 0, length], bore / 2.0);
let loop_ = cylinder([0, -1.5, length + r + 2.0], "Y", 4.0, 3.0) - cylinder([0, -2.0, length + r + 2.0], "Y", 2.0, 4.0);
c + loop_
