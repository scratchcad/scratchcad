// USB-C receptacle (mid-mount): 8.94 x 3.26 mm stadium shell 7.35 mm deep, tongue 6.7 x 0.6 mm, 0.25 mm wall
let width = 8.94; // [8.6, 9.2] Shell width (mm)
let height = 3.26; // [3.0, 3.5] Shell height (mm)
let depth = 7.35; // [6.5, 9.0] Depth (mm)
let wall = 0.25; // [0.2, 0.4] Wall (mm)
let stadium = |w, h| box_centered(w - h, depth, h) + cylinder([-(w - h) / 2.0, -depth / 2.0, 0], "Y", h / 2.0, depth) + cylinder([(w - h) / 2.0, -depth / 2.0, 0], "Y", h / 2.0, depth);
let shell = stadium.call(width, height) - stadium.call(width - 2.0 * wall, height - 2.0 * wall).translate([0, -wall, 0]);
let tongue = box_centered(6.7, depth - 1.0, 0.6).translate([0, 0.5, 0]);
shell + tongue
