// Glass shower door hinge cover: 90 x 55 x 12 mm cover plate with 3 mm walls, 5 mm corner radii, open back and two 6 mm screw cap bosses on 60 mm centres
let length = 90.0; // [70.0, 120.0] Cover length (mm)
let depth = 12.0; // [8.0, 18.0] Cover depth (mm)
const w = 55.0;
const wall = 3.0;
let c = box_centered(length, w, depth).translate([0, 0, depth / 2.0]);
let c = c.fillet(5.0, c.edges("|Z"));
let c = c - box_centered(length - 2.0 * wall, w - 2.0 * wall, depth).translate([0, 0, depth / 2.0 - wall]);
let bosses = cylinder([-30.0, 0, 0], "Z", 4.5, depth - 0.01) + cylinder([30.0, 0, 0], "Z", 4.5, depth - 0.01);
c + bosses - cylinder([-30.0, 0, -1.0], "Z", 3.0, depth - wall + 1.0) - cylinder([30.0, 0, -1.0], "Z", 3.0, depth - wall + 1.0)
