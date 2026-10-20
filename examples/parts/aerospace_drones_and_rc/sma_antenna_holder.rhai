// TPU SMA antenna holder: 14 x 14 x 8 mm block with zip-tie slot, 45 deg tube 8 mm OD with a 6.5 mm SMA bore
let angle = 45.0; // [0.0, 60.0] Tilt from vertical (deg)
let a = angle * PI() / 180.0;
let dir = [0, a.sin(), a.cos()];
let block = box_centered(14.0, 14.0, 8.0).translate([0, 0, 4.0]) - box_centered(16.0, 3.5, 1.6).translate([0, 0, 1.5]);
let tube = cylinder([0, 0, 4.0], dir, 4.0, 22.0);
block + tube - cylinder([0, 0, 4.0], dir, 3.25, 23.0)
