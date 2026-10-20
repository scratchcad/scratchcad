// Fire alarm call point protective cover: 100 x 100 x 30 mm hinged-lid shell 2 mm, 85 x 85 mm opening at the back
let size = 100.0; // [85.0, 120.0] Cover size (mm)
let depth = 30.0; // [20.0, 45.0] Depth (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let shell = box_centered(size, size, depth).translate([0, 0, depth / 2.0]);
let s = shell.fillet(6.0, shell.edges("|Z"));
let cav = box_centered(size - 2.0 * wall, size - 2.0 * wall, depth).translate([0, 0, depth / 2.0 - wall]);
let c = cav.fillet(4.0, cav.edges("|Z"));
let hinge = cylinder([-size / 2.0 + 10.0, size / 2.0, depth - 3.0], "X", 3.0, size - 20.0) - cylinder([-size / 2.0 + 9.0, size / 2.0, depth - 3.0], "X", 1.2, size - 18.0);
s - c + hinge - box_centered(30.0, 6.0, 4.0).translate([0, -size / 2.0 + 8.0, depth])
