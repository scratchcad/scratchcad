// Speaker terminal cup: 100 x 100 mm plate 3 mm with a 70 x 70 mm recess 25 mm deep (2.5 mm walls), two 8 mm binding post holes 19 mm apart (3/4 inch) and four 4 mm corner screw holes
let size = 100.0; // [80.0, 130.0] Plate size (mm)
let depth = 25.0; // [15.0, 35.0] Recess depth (mm)
const wall = 2.5;
let plate = box_centered(size, size, 3.0).translate([0, 0, -1.5]);
let box_ = box_centered(70.0 + 2.0 * wall, 70.0 + 2.0 * wall, depth).translate([0, 0, -depth / 2.0]);
let c = plate + box_ - box_centered(70.0, 70.0, depth).translate([0, 0, -depth / 2.0 + wall]);
let holes = [cylinder([-9.5, 0, -depth - 1.0], "Z", 4.0, 5.0), cylinder([9.5, 0, -depth - 1.0], "Z", 4.0, 5.0)];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * (size / 2.0 - 7.0), sy * (size / 2.0 - 7.0), -5.0], "Z", 2.0, 10.0)); } }
c - fuse_all(holes)
