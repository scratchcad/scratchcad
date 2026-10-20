// Wall-mounted ice machine scoop holder: open-top pocket 120 x 60 x 150 mm with 3 mm walls, front cut down to 90 mm, six 8 mm drain holes in the floor and two 5 mm screw holes in the back
let width = 120.0; // [90.0, 160.0] Pocket width (mm)
let depth = 60.0; // [40.0, 90.0] Pocket depth (mm)
let height = 150.0; // [110.0, 200.0] Back height (mm)
let front = 90.0; // [50.0, 100.0] Front height (mm)
const wall = 3.0;
let pocket = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, depth, height]).shell(-wall, ">Z");
pocket = pocket - box_from_corners([-width / 2.0 + 10.0, depth - wall - 1.0, front], [width / 2.0 - 10.0, depth + 1.0, height + 1.0]);
let holes = [];
for i in 0..3 {
    for j in 0..2 {
        holes.push(cylinder([(i.to_float() - 1.0) * width / 4.0, depth / 3.0 * (j.to_float() + 1.0), -1.0], "Z", 4.0, wall + 2.0));
    }
}
for sx in [-1.0, 1.0] { holes.push(cylinder([sx * width / 4.0, -1.0, height - 20.0], "Y", 2.5, wall + 2.0)); }
pocket - compound(holes)
