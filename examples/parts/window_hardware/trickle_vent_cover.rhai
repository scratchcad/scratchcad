// Window trickle vent cover: 250 x 25 mm, 15 mm deep hood 1.5 mm, 20 louvre slots 2 mm, 2 screw holes
let length = 250.0; // [150.0, 400.0] Length (mm)
let height = 25.0; // [18.0, 35.0] Height (mm)
let depth = 15.0; // [8.0, 20.0] Hood depth (mm)
let wall = 1.5; // [1.0, 2.5] Wall (mm)
let hood = box_from_corners([0, 0, 0], [length, depth, height]) - box_from_corners([wall, -1, wall], [length - wall, depth - wall, height - wall]);
let slots = [];
let n = ((length - 40.0) / 10.0).floor().to_int();
for k in 0..n { slots.push(box_from_corners([20.0 + k.to_float() * 10.0, depth - wall - 1.0, 5.0], [22.0 + k.to_float() * 10.0, depth + 1.0, height - 5.0])); }
hood - compound(slots) - cylinder([10.0, -1, height / 2.0], "Y", 1.75, depth + 2.0) - cylinder([length - 10.0, -1, height / 2.0], "Y", 1.75, depth + 2.0)
