// Pyramid newel post cap for a 90 mm post: 100 mm base 20 mm thick, 40 mm pyramid, 24 mm ball finial, 15 mm deep post socket
let post = 90.0; // [70.0, 150.0] Post size (mm)
let w = post + 10.0;
let base = box_centered(w, w, 20.0).translate([0, 0, 10.0]).chamfer(2.0, ">Z");
let pyramid = loft([rect(plane([0, 0, 19.9], "Z"), w - 4.0, w - 4.0), rect(plane([0, 0, 60.0], "Z"), 6.0, 6.0)], true);
let cap = fuse_all([base, pyramid, sphere([0, 0, 70.0], 12.0)]);
cap - box_centered(post + 0.5, post + 0.5, 30.0)
