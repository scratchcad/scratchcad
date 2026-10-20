// 1:76 sleeper-built coal staithe: 40 x 25 mm, 10 mm tall walls of 3.3 mm sleepers on three sides
let length = 40.0; // [25.0, 80.0] Length (mm)
let depth = 25.0; // [15.0, 40.0] Depth (mm)
let height = 10.0; // [6.0, 16.0] Wall height (mm)
let sleeper = 3.3; // [2.6, 4.0] Sleeper depth (mm)
let back = box_from_corners([0, depth - 1.6, 0], [length, depth, height]);
let sides = box_from_corners([0, 0, 0], [1.6, depth, height]) + box_from_corners([length - 1.6, 0, 0], [length, depth, height]);
let base = box_from_corners([0, 0, 0], [length, depth, 0.5]);
let joints = [];
let n = (height / sleeper).floor().to_int();
for k in 1..=n { joints.push(box_from_corners([-1, -1, k.to_float() * sleeper - 0.1], [length + 1.0, depth + 1.0, k.to_float() * sleeper + 0.1]) - box_from_corners([0.15, 0.15, 0], [length - 0.15, depth - 0.15, height + 1.0])); }
let posts = [];
for x in [length / 3.0, 2.0 * length / 3.0] { posts.push(box_from_corners([x - 0.8, depth - 0.01, 0], [x + 0.8, depth + 1.2, height + 1.0])); }
back + sides + base - compound(joints) + fuse_all(posts)
