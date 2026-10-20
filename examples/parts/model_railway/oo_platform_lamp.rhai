// 1:76 station gas lamp post: 40 mm, fluted 1.6 mm column, ladder bar, square lantern 4 x 6 mm
let scale_ = 76.0; // [43.5, 160.0] Scale ratio
let s = 76.0 / scale_;
let base = cylinder(1.6, 3.0) + cone(1.6, 0.8, 2.0).translate([0, 0, 2.99]);
let col = cylinder([0, 0, 4.98], "Z", 0.8, 30.0);
let bar = box_centered(5.0, 0.4, 0.4).translate([0, 0, 33.0]);
let lantern = loft([rect(plane([0, 0, 34.9], [0, 0, 1]), 2.4, 2.4), rect(plane([0, 0, 38.0], [0, 0, 1]), 4.0, 4.0)], true) + cone(2.8, 0.4, 2.0).translate([0, 0, 37.99]) + sphere([0, 0, 40.2], 0.5);
(base + col + bar + lantern).scale(s)
