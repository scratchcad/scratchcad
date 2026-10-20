// Thumb page holder: 22 mm thumb hole in a 70 x 18 x 4 mm flat paddle with rounded ends
let hole = 22.0; // [16.0, 28.0] Thumb hole (mm)
let span = 70.0; // [50.0, 90.0] Paddle span (mm)
let width = 18.0; // [14.0, 24.0] Paddle width (mm)
let t = 4.0; // [3.0, 6.0] Thickness (mm)
let paddle = box_centered(span, width, t).translate([0, 0, t / 2.0]);
let p = paddle.fillet(width / 2.0 - 0.5, paddle.edges("|Z"));
let ring = cylinder(hole / 2.0 + 4.0, t);
p + ring - cylinder([0, 0, -1], "Z", hole / 2.0, t + 2.0)
