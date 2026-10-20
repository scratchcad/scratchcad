// Violin chinrest (Guarneri style): 70 x 45 mm stadium cup 14 mm tall, dished 8 mm, two clamp feet 10 mm
let length = 70.0; // [60.0, 85.0] Cup length (mm)
let width = 45.0; // [35.0, 55.0] Cup width (mm)
let height = 14.0; // [10.0, 22.0] Height (mm)
let dish = 8.0; // [4.0, 12.0] Dish depth (mm)
let body = box_centered(length, width, height).translate([0, 0, height / 2.0]);
let b = body.fillet(width / 2.0 - 0.01, body.edges("|Z"));
let rs = (length * length / 4.0 + dish * dish) / (2.0 * dish);
let cup = b - sphere([0, 0, height - dish + rs], rs);
let feet = box_from_corners([-length / 2.0 + 6.0, -5.0, -10.0], [-length / 2.0 + 14.0, 5.0, 0.01]) + box_from_corners([length / 2.0 - 14.0, -5.0, -10.0], [length / 2.0 - 6.0, 5.0, 0.01]);
cup + feet - cylinder([-length / 2.0 + 10.0, -6.0, -6.0], "Y", 1.5, 12.0) - cylinder([length / 2.0 - 10.0, -6.0, -6.0], "Y", 1.5, 12.0)
