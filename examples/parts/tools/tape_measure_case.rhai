// 5 m tape measure case: 65 x 65 x 35 mm with 10 mm rounded corners, blade slot, lock button and belt clip
let s = 65.0; // [50.0, 90.0] Case size (mm)
let t = 35.0; // [25.0, 45.0] Thickness (mm)
let c = box_from_corners([0, 0, 0], [s, s, t]).fillet(10.0, "|Z").fillet(2.0, ">Z or <Z");
c -= box_from_corners([-1.0, 3.0, t / 2.0 - 10.0], [6.0, 5.0, t / 2.0 + 10.0]);
c += box_from_corners([12.0, s - 1.0, t / 2.0 - 5.0], [28.0, s + 3.0, t / 2.0 + 5.0]).fillet(1.5, ">Y");
let clip = box_from_corners([15.0, 10.0, -3.5], [s - 15.0, s - 15.0, -1.5]) + box_from_corners([15.0, s - 25.0, -1.6], [s - 15.0, s - 15.0, 0.1]);
c + clip
