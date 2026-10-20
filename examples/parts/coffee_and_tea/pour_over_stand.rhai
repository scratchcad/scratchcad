// Pour-over stand: 150 mm tall C-frame, 120 x 120 mm base 8 mm, 90 mm dripper ring 6 mm with a 70 mm opening
let height = 150.0; // [100.0, 220.0] Ring height above base (mm)
let ring_od = 90.0; // [70.0, 130.0] Ring outside diameter (mm)
let opening = 70.0; // [50.0, 110.0] Ring opening (mm)
let base = box_centered(120.0, 120.0, 8.0).translate([0, 0, 4.0]);
let b = base.fillet(10.0, base.edges("|Z"));
let post = box_from_corners([-60.0, -15.0, 7.99], [-48.0, 15.0, height + 6.0]);
let arm = box_from_corners([-60.0, -15.0, height], [0, 15.0, height + 6.0]);
let ring = cylinder([0, 0, height], "Z", ring_od / 2.0, 6.0) - cylinder([0, 0, height - 1.0], "Z", opening / 2.0, 8.0);
b + post + arm + ring
