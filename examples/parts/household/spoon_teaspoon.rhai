// Teaspoon: 140 mm long, 28 x 42 mm bowl lofted 7 mm deep, tapered 2 mm handle bending up 8 mm
let length = 140.0; // [100.0, 200.0] Overall length (mm)
let bowl_w = 28.0; // [27.9, 45.0] Bowl width (mm)
let bowl_l = 42.0; // [30.0, 70.0] Bowl length (mm)
let depth = 7.0; // [4.6, 7.1] Bowl depth (mm)
let thickness = 1.6; // [1.0, 3.0] Thickness (mm)
let outer = (sphere(1.0).scale(1.0) & box_centered(4, 4, 2).translate([0, 0, -1])).scale(1.0);
let bowl_shape = sphere([0, 0, depth], depth).scale([0, 0, 0], 1.0);
let bowl = (sphere(bowl_w / 2.0).translate([0, 0, bowl_w / 2.0 - depth]) & box_centered(bowl_w, bowl_w, depth).translate([0, 0, depth / 2.0]));
bowl = bowl.shell(-thickness, ">Z");
let handle = loft([rect(plane([bowl_w / 2.0 - 3.0, 0, depth - thickness], "X", "Y"), 8.0, thickness), rect(plane([length - bowl_l / 2.0, 0, depth + 8.0], "X", "Y"), 12.0, thickness * 1.3)], true);
(bowl + handle)
