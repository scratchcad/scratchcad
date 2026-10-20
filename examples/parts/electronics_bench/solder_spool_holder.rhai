// Solder spool holder: 90 x 60 mm base, 50 mm upright with 15 mm axle for 250 g spools, wire guide eye 3 mm
let base_l = 90.0; // [60.0, 120.0] Base length (mm)
let axle_d = 15.0; // [8.0, 20.0] Axle diameter (mm)
let axle_l = 60.0; // [40.0, 80.0] Axle length (mm)
let base = box_from_corners([0, -30.0, 0], [base_l, 30.0, 6.0]);
let b = base.fillet(5.0, base.edges("|Z"));
let upright = box_from_corners([0, -30.0, 5.99], [8.0, 30.0, 60.0]);
let u = upright.fillet(29.0, upright.edges("|X and >Z"));
let axle = cylinder([7.99, 0, 40.0], "X", axle_d / 2.0, axle_l) + cylinder([axle_l + 7.0, 0, 40.0], "X", axle_d / 2.0 + 2.0, 3.0);
let guide = cylinder([base_l - 8.0, 0, 5.99], "Z", 3.0, 30.0) + (cylinder([base_l - 8.0, -2.0, 38.0], "Y", 5.0, 4.0) - cylinder([base_l - 8.0, -3.0, 38.0], "Y", 1.5, 6.0));
b + u + axle + guide
