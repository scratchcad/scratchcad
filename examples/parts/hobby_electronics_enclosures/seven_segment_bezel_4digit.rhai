// Bezel for a 0.56 in 4-digit 7-segment display (50.4 x 19 x 8 mm, TM1637 module 42 x 24 mm PCB, M2 holes on 37 x 19 mm): 66 x 30 x 2 mm plate, 50.8 x 19.4 mm window, 1.5 mm locating wall around the display 5 mm deep, 2 x M3 panel holes
let plate_w = 66.0; // [60.0, 90.0] Bezel width (mm)
let plate_h = 30.0; // [24.0, 45.0] Bezel height (mm)
let thick = 2.0; // [1.5, 3.5] Plate thickness (mm)
let window_w = 50.8; // [30.0, 52.0] Display width (mm)
let window_h = 19.4; // [12.0, 20.0] Display height (mm)
let wall_h = 5.0; // [2.0, 8.0] Locating wall depth (mm)
let pw = max(plate_w, window_w + 14.0);
let ph = max(plate_h, window_h + 6.0);
let plate = box_centered(pw, ph, thick).translate([0, 0, thick / 2.0]);
let plate = plate.fillet(2.5, plate.edges("|Z"));
let wall = box_centered(window_w + 3.0, window_h + 3.0, wall_h + 0.5).translate([0, 0, thick + wall_h / 2.0 - 0.25]);
let body = plate + wall;
let window = box_from_corners([-window_w / 2.0, -window_h / 2.0, thick * 0.5], [window_w / 2.0, window_h / 2.0, thick + wall_h + 1.0]);
let lip = box_centered(window_w - 2.0, window_h - 2.0, thick * 3.0);
let px = (pw + window_w + 3.0) / 4.0;
body - (window + lip) - cylinder([-px, 0, -1], "Z", 1.6, thick + 2.0) - cylinder([px, 0, -1], "Z", 1.6, thick + 2.0)
