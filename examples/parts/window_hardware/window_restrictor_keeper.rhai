// Window restrictor cable keeper: 50 x 18 x 12 mm block with a 4 mm cable-end T-slot and 2 countersunk holes
let length = 50.0; // [35.0, 70.0] Keeper length (mm)
let width = 18.0; // [14.0, 25.0] Width (mm)
let height = 12.0; // [10.0, 16.0] Height (mm)
let b = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, height]);
let bb = b.fillet(3.0, b.edges("|Y and >Z"));
let slot = box_from_corners([length / 2.0 - 2.0, -width, height - 5.0], [length / 2.0 + 2.0, width, height + 1.0]) + box_from_corners([length / 2.0 - 5.0, -width, height - 9.0], [length / 2.0 + 5.0, width, height - 5.0]);
let holes = [];
for x in [7.0, length - 7.0] { holes.push(cylinder([x, 0, -1], "Z", 2.0, height + 2.0) + cone(2.0, 4.0, 2.0).translate([x, 0, height - 1.99])); }
bb - slot - fuse_all(holes)
