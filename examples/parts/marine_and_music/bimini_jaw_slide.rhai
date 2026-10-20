// Bimini top jaw slide for 22 mm (7/8 in) tube: split collar 30 mm long with a 8 mm thumb screw boss and a 5 mm pin jaw
let tube = 22.2; // [19.0, 25.4] Tube diameter (mm)
let r = tube / 2.0;
let collar = cylinder([0, 0, 0], "Z", r + 3.0, 30.0) - cylinder([0, 0, -1], "Z", r + 0.2, 32.0) - box_from_corners([-1.0, r - 1.0, -1], [1.0, r + 5.0, 31.0]);
let boss = box_from_corners([-6.0, r + 1.0, 8.0], [6.0, r + 9.0, 22.0]) - box_from_corners([-1.0, r - 1.0, 7.0], [1.0, r + 10.0, 23.0]) - cylinder([-8.0, r + 5.0, 15.0], "X", 2.0, 16.0);
let jaw = box_from_corners([-7.0, -r - 18.0, 5.0], [7.0, -r + 1.0, 25.0]) - box_from_corners([-3.0, -r - 19.0, 4.0], [3.0, -r - 4.0, 26.0]) - cylinder([-8.0, -r - 12.0, 15.0], "X", 2.6, 16.0);
fuse_all([collar, boss, jaw])
