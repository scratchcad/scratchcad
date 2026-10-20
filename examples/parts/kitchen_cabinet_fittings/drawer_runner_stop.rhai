// Drawer runner end stop: 40 x 15 mm stop block 12 mm tall screwed into a cabinet side, with a 3 mm rubber bumper recess 10 mm and two 4 mm countersunk holes
let length = 40.0; // [30.0, 60.0] Stop length (mm)
let height = 12.0; // [8.0, 20.0] Stop height (mm)
let b = box_from_corners([0, 0, 0], [length, 15.0, height]);
let b = b.fillet(2.0, b.edges("|Z"));
let holes = [];
for x in [8.0, length - 8.0] { holes.push(cylinder([x, 7.5, -1.0], "Z", 2.0, height + 2.0)); holes.push(cone(2.0, 4.0, 2.0).translate([x, 7.5, height - 1.99])); }
b - fuse_all(holes) - cylinder([length / 2.0, -1.0, height / 2.0], "Y", 5.0, 4.0)
