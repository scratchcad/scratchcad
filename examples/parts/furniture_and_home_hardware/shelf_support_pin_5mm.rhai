// L shelf support pin: 5 mm pin 8 mm long, 7 mm wide back plate 10 mm tall and ledge 10 mm deep, 1.5 mm steel
let pin_d = 5.0; // [3.0, 8.0] Pin diameter (mm)
let w = 7.0; // [5.0, 12.0] Width (mm)
let back = box_from_corners([-w / 2.0, 0, -5.0], [w / 2.0, 1.5, 5.0]);
let ledge = box_from_corners([-w / 2.0, 0, -5.0], [w / 2.0, 10.0, -3.5]);
let pin = cylinder([0, 0, 0], "-Y", pin_d / 2.0, 8.0).chamfer(0.4, "<Y");
fuse_all([back, ledge, pin])
