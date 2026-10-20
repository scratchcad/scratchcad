// Rear seat belt buckle holder: 35 x 25 mm sleeve 60 mm tall for a 30 x 18 mm buckle, 2 mm wall, open top
let w = 30.0; // [25.0, 40.0] Buckle width (mm)
let d = 18.0; // [12.0, 25.0] Buckle depth (mm)
let height = 60.0; // [40.0, 90.0] Sleeve height (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let outer = box_centered(w + 2.0 * wall, d + 2.0 * wall, height).translate([0, 0, height / 2.0]);
let o = outer.fillet(4.0, outer.edges("|Z"));
let inner = box_centered(w, d, height + 2.0).translate([0, 0, height / 2.0]);
let i = inner.fillet(2.0, inner.edges("|Z"));
let foot = box_centered(w + 16.0, d + 2.0 * wall, 3.0).translate([0, 0, 1.5]) - box_centered(w + 0.5, d, 4.0).translate([0, 0, 1.5]);
o - i + foot - cylinder([-w / 2.0 - 5.0, 0, -1], "Z", 1.6, 5.0) - cylinder([w / 2.0 + 5.0, 0, -1], "Z", 1.6, 5.0)
