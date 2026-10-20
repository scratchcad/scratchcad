// RC tail wheel: 24 mm wheel 6 mm wide with rounded tyre and 3 mm axle, 1 mm sheet fork, 2 mm steering wire 30 mm long
let d = 24.0; // [16.0, 40.0] Wheel diameter (mm)
let r = d / 2.0;
let wheel = (cylinder([0, -3.0, 0], "Y", r, 6.0).fillet(2.5, "%CIRCLE") - cylinder([0, -4.0, 0], "Y", 1.5, 8.0));
let fork = fuse_all([
    box_from_corners([-3.0, -4.6, -2.0], [3.0, -3.6, r + 4.0]),
    box_from_corners([-3.0, 3.6, -2.0], [3.0, 4.6, r + 4.0]),
    box_from_corners([-3.0, -4.6, r + 3.0], [3.0, 4.6, r + 4.0]),
    cylinder([0, -4.6, 0], "Y", 1.4, 9.2),
    cylinder([0, 0, r + 4.0], "Z", 1.0, 30.0)
]);
compound([wheel, fork])
