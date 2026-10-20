// Key tag: 50 x 20 x 3 mm rounded tag with a 5 mm ring hole and a 1 mm recessed label area
let length = 50.0; // [30.0, 80.0] Length (mm)
let width = 20.0; // [12.0, 35.0] Width (mm)
let thickness = 3.0; // [2.0, 6.0] Thickness (mm)
let tag = box(length, width, thickness).fillet(width * 0.45, "|Z");
tag = tag - box_from_corners([12.0, 3.0, thickness - 1.0], [length - 3.0, width - 3.0, thickness + 1.0]).fillet(2.0, "|Z");
tag - cylinder([6.0, width / 2.0, -1], "Z", 2.5, thickness + 2.0)
