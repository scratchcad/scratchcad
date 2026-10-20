// Table saw / jointer push block: 120 x 75 x 12 mm shoe, 6 mm heel hook at the back, closed tote handle 80 mm long rising to 70 mm with a 50 x 30 mm hand hole
let length = 120.0; // [90.0, 180.0] Shoe length (mm)
let width = 75.0; // [50.0, 100.0] Shoe width (mm)
let shoe_t = 12.0; // [8.0, 19.0] Shoe thickness (mm)
let heel = 6.0; // [3.0, 12.0] Heel hook depth (mm)
let handle_h = 70.0; // [50.0, 100.0] Handle top height (mm)
let shoe = box_from_corners([0, 0, 0], [length, width, shoe_t]);
let s = shoe.fillet(4.0, shoe.edges("|Z"));
let hook = box_from_corners([0, 0, -heel], [8.0, width, 0.5]);
let hx0 = length * 0.2;
let hx1 = length * 0.88;
let handle = box_from_corners([hx0, width / 2.0 - 8.0, shoe_t - 0.5], [hx1, width / 2.0 + 8.0, handle_h]);
let h = handle.fillet(10.0, handle.edges("|Y and >Z"));
let hole = box_from_corners([hx0 + 14.0, width / 2.0 - 9.0, shoe_t + 10.0], [hx1 - 14.0, width / 2.0 + 9.0, handle_h - 14.0]);
s + hook + h - hole
