// Wooden drawer runner guide strip: 400 mm long 12 x 10 mm with a 1 mm top chamfer and 4 countersunk holes
let length = 400.0; // [250.0, 600.0] Runner length (mm)
let width = 12.0; // [8.0, 20.0] Width (mm)
let height = 10.0; // [6.0, 15.0] Height (mm)
let r = box_from_corners([0, 0, 0], [length, width, height]);
let rr = r.chamfer(1.0, r.edges("|X and >Z"));
let holes = [];
for k in 0..4 { let x = 25.0 + k.to_float() * (length - 50.0) / 3.0; holes.push(cylinder([x, width / 2.0, -1], "Z", 1.75, height + 2.0) + cone(1.75, 4.0, 2.25).translate([x, width / 2.0, height - 2.24])); }
rr - fuse_all(holes)
