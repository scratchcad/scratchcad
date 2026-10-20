// Wall cabinet hanging bracket plate: 60 x 50 x 3 mm plate with a 12 mm hook tongue that rides on a steel wall rail, a 6 x 12 mm adjustment slot and three 4 mm screw holes
let width = 60.0; // [45.0, 80.0] Plate width (mm)
let hook = 12.0; // [8.0, 18.0] Hook depth (mm)
const t = 3.0;
let p = box_from_corners([0, 0, 0], [width, t, 50.0]);
let tongue = box_from_corners([width / 2.0 - 10.0, -hook, 45.0], [width / 2.0 + 10.0, t, 45.0 + t]) + box_from_corners([width / 2.0 - 10.0, -hook, 38.0], [width / 2.0 + 10.0, -hook + t, 45.0 + t]);
let holes = [box_from_corners([width / 2.0 - 3.0, -1.0, 15.0], [width / 2.0 + 3.0, t + 1.0, 27.0])];
for x in [8.0, width - 8.0] { holes.push(cylinder([x, -1.0, 10.0], "Y", 2.0, t + 2.0)); }
holes.push(cylinder([width / 2.0, -1.0, 35.0], "Y", 2.0, t + 2.0));
p + tongue - fuse_all(holes)
