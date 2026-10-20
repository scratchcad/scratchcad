// Folding magnetic bookmark: two 20 x 50 x 0.6 mm leaves joined by a 2 mm living hinge, 10 mm magnet pockets 0.4 mm deep in each
let w = 20.0; // [15.0, 30.0] Width (mm)
let len = 50.0; // [30.0, 70.0] Leaf length (mm)
let leaf = box_from_corners([0, 0, 0], [w, len, 0.6]).fillet(3.0, "|Z and >Y") - cylinder([w / 2.0, len - 12.0, 0.2], "Z", 5.0, 1.0);
let hinge = box_from_corners([0, -2.0, 0], [w, 0.01, 0.3]);
leaf + hinge + leaf.mirror([0, 1, 0]).translate([0, -2.0, 0])
