// Trigger guitar capo: two 70 mm arms 18 mm wide pivoting on a 4 mm pin, silicone pad strip on the lower arm, spring post
let span = 70.0; // [55.0, 90.0] Arm length (mm)
let upper = box_from_corners([0, -9.0, 0], [span, 9.0, 8.0]).fillet(3.0, "|Z") + cylinder([span - 10.0, -9.0, -6.0], "Y", 8.0, 18.0);
let lower = box_from_corners([0, -9.0, -30.0], [span - 12.0, 9.0, -24.0]).fillet(3.0, "|Z") + box_from_corners([span - 20.0, -9.0, -30.0], [span - 4.0, 9.0, -6.0]);
lower = lower - cylinder([span - 10.0, -10.0, -6.0], "Y", 8.3, 20.0) + cylinder([span - 10.0, -9.0, -6.0], "Y", 2.0, 18.0);
let pad = box_from_corners([2.0, -8.0, -24.0], [span - 22.0, 8.0, -20.0]).fillet(1.5, ">Z");
compound([upper - cylinder([span - 10.0, -10.0, -6.0], "Y", 2.1, 20.0), lower, pad])
