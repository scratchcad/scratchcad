// Oblique calligraphy pen flange: clamps a 10 mm holder barrel, 12 mm long sleeve with a 25 mm arm angled 55 degrees carrying a 3 x 1 mm nib slot 8 mm deep
let barrel = 10.0; // [8.0, 13.0] Holder barrel diameter (mm)
let angle = 55.0; // [40.0, 70.0] Flange angle (degrees)
const wall = 2.0;
let sleeve = cylinder([0, 0, 0], "Z", barrel / 2.0 + wall, 12.0) - cylinder([0, 0, -1.0], "Z", barrel / 2.0, 14.0);
let arm = box_from_corners([0, -2.5, 0], [6.0, 2.5, 25.0]).rotate_y(angle).translate([barrel / 2.0 + wall - 1.5, 0, 10.0]);
sleeve + arm - (box_from_corners([2.0, -0.5, 17.0], [5.0, 0.5, 26.0]).rotate_y(angle).translate([barrel / 2.0 + wall - 1.5, 0, 10.0]))
