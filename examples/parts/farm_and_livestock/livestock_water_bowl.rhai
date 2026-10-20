// Livestock drinking bowl: 270 mm wide cast bowl 4 l, 130 mm deep, back mount flange with 4 x 10 mm holes, valve paddle boss
let width = 270.0; // [200.0, 350.0] Bowl width (mm)
let depth = 130.0; // [90.0, 180.0] Bowl depth (mm)
let wall = 5.0; // [3.0, 8.0] Wall (mm)
let r = width / 2.0;
let outer = sphere([0, 0, depth], r) & box_from_corners([-r, -r, 0], [r, 0, depth]);
let o2 = (sphere([0, 0, depth], r) & box_from_corners([-r, 0, 0], [r, r, depth])) & box_from_corners([-r, -r, 0], [r, r * 0.6, depth]);
let bowl = (outer + o2) - sphere([0, 0, depth + 0.01], r - wall);
let flange = box_from_corners([-r * 0.6, r * 0.6 - 0.01, 0], [r * 0.6, r * 0.6 + 8.0, depth + 60.0]);
let holes = [];
for x in [-r * 0.45, r * 0.45] { for z in [depth * 0.3, depth + 40.0] { holes.push(cylinder([x, r * 0.6 - 1.0, z], "Y", 5.0, 10.0)); } }
let boss = cylinder([0, r * 0.6 - 14.0, depth - 0.01], "Z", 15.0, 40.0) - cylinder([0, r * 0.6 - 14.0, depth - 1.0], "Z", 10.0, 42.0);
(bowl & box_from_corners([-r, -r, 0], [r, r * 0.6, depth])) + flange + boss - compound(holes)
