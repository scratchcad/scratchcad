// Pegboard parts bin: 100 x 60 x 50 mm open-front bin, 2 mm walls, 2 hooks for 1/4 in pegboard on 25.4 mm pitch
let width = 100.0; // [60.0, 150.0] Bin width (mm)
let depth = 60.0; // [40.0, 100.0] Bin depth (mm)
let height = 50.0; // [30.0, 80.0] Bin height (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let bin = box_from_corners([0, 0, 0], [width, depth, height]);
let inner = box_from_corners([wall, wall, wall], [width - wall, depth - wall, height + 1.0]);
let front = polygon([[0, -1, height * 0.5], [0, -1, height + 1.0], [0, depth * 0.5, height + 1.0]]).to_face().extrude([width + 2.0, 0, 0]).translate([-1.0, 0, 0]);
let hooks = [];
for x in [width / 2.0 - 25.4, width / 2.0 + 25.4] { hooks.push(box_from_corners([x - 2.5, depth - 0.01, height - 10.0], [x + 2.5, depth + 7.0, height - 5.0]) + box_from_corners([x - 2.5, depth + 3.0, height - 10.0], [x + 2.5, depth + 7.0, height + 6.0])); }
bin - inner - front + fuse_all(hooks)
