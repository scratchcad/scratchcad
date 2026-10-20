// PIR sensor mount for a 23 mm Fresnel dome: 50 x 50 x 25 mm box, 23.2 mm dome hole, 32 x 24 mm PCB ledge with M2 posts
let size = 50.0; // [40.0, 70.0] Box size (mm)
let depth = 25.0; // [18.0, 35.0] Box depth (mm)
let dome = 23.2; // [22.0, 24.0] Dome hole (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let shell = box_centered(size, size, depth).translate([0, 0, depth / 2.0]);
let s = shell.fillet(5.0, shell.edges("|Z"));
let cav = box_centered(size - 2.0 * wall, size - 2.0 * wall, depth).translate([0, 0, depth / 2.0 + wall]);
let c = cav.fillet(3.0, cav.edges("|Z"));
let posts = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { posts.push(cylinder([sx * 14.0, sy * 10.0, wall - 0.01], "Z", 2.0, 6.0) - cylinder([sx * 14.0, sy * 10.0, wall + 1.0], "Z", 0.8, 6.0)); } }
s - c - cylinder([0, 0, -1], "Z", dome / 2.0, wall + 2.0) + fuse_all(posts)
