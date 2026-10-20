// 1U CubeSat side frame: 100 x 113.5 mm, 8.5 mm square rails, 2 mm skin, 80 x 80 mm lightening window, 4 x M3 holes
let width = 100.0; // [98.0, 100.0] Frame width (mm)
let height = 113.5; // [113.0, 114.0] Rail length (mm)
let rail = 8.5; // [6.0, 10.0] Rail size (mm)
let skin = 2.0; // [1.5, 3.0] Panel thickness (mm)
let panel = box_from_corners([0, 0, 0], [width, skin, height]);
let rails = box_from_corners([0, 0, 0], [rail, rail, height]) + box_from_corners([width - rail, 0, 0], [width, rail, height]);
let window = box_from_corners([10.0, -1, 16.75], [width - 10.0, skin + 1.0, height - 16.75]);
let w = window.fillet(6.0, window.edges("|Y"));
let holes = [];
for x in [rail + 6.0, width - rail - 6.0] { for z in [8.0, height - 8.0] { holes.push(cylinder([x, -1, z], "Y", 1.6, skin + 2.0)); } }
panel + rails - w - compound(holes)
