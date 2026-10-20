// Tape-measure antenna burn-wire post: 8 x 8 x 10 mm block, 1.2 mm Dyneema line hole, 2 resistor slots 1.6 mm, M2 base hole
let size = 8.0; // [6.0, 12.0] Post size (mm)
let height = 10.0; // [6.0, 15.0] Post height (mm)
let p = box_centered(size, size, height).translate([0, 0, height / 2.0]);
let pp = p.chamfer(0.5, p.edges(">Z"));
pp - cylinder([-size, 0, height - 3.0], "X", 0.6, size * 2.0) - box_centered(1.6, size + 2.0, 3.0).translate([-1.5, 0, height - 1.0]) - box_centered(1.6, size + 2.0, 3.0).translate([1.5, 0, height - 1.0]) - cylinder([0, 0, -1], "Z", 0.8, 5.0)
