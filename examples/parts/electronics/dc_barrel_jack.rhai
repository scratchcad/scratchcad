// DC barrel jack 5.5 x 2.1 mm: 9 x 14 x 11 mm body, 6.3 mm socket, 2.1 mm centre pin, three solder tabs
let width = 9.0; // [8.0, 12.0] Width (mm)
let depth = 14.0; // [11.6, 16.0] Depth (mm)
let height = 11.0; // [10.0, 13.0] Height (mm)
let body = box_centered(width, depth, height).translate([0, 0, height / 2.0]) + cylinder([0, -depth / 2.0 - 0.01, 6.5], "Y", 4.5, 3.0).translate([0, -2.99, 0]);
body = body - cylinder([0, -depth / 2.0 - 4.0, 6.5], "Y", 3.15, depth);
let pin = cylinder([0, -depth / 2.0 - 2.0, 6.5], "Y", 1.0, depth * 0.8);
let tabs = box_centered(3.0, 0.4, 3.5).translate([0, depth / 2.0 - 0.2, -1.5]) + box_centered(0.4, 3.0, 3.5).translate([width / 2.0 - 0.2, 0, -1.5]) + box_centered(3.0, 0.4, 3.5).translate([0, -1.5, -1.5]);
fuse_all([body, pin, tabs])
