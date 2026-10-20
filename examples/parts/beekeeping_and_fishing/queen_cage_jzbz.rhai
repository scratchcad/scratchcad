// JZ-BZ style queen cage: 70 x 17 x 13 mm, 1.5 mm wall, 2.5 mm vent slots, candy tube 9 mm with 3 mm exit
let length = 70.0; // [55.0, 90.0] Length (mm)
let width = 17.0; // [14.0, 22.0] Width (mm)
let height = 13.0; // [10.0, 18.0] Height (mm)
let wall = 1.5; // [1.0, 2.0] Wall (mm)
let outer = box_from_corners([0, 0, 0], [length, width, height]);
let inner = box_from_corners([wall, wall, wall], [length - 20.0, width - wall, height - wall]);
let vents = [];
for k in 0..10 { vents.push(box_from_corners([5.0 + k.to_float() * 4.5, -1, 3.0], [7.5 + k.to_float() * 4.5, width + 1.0, height - 3.0])); }
outer - inner - compound(vents) - cylinder([length - 21.0, width / 2.0, height / 2.0], "X", 4.5 - wall, 18.0) - cylinder([length - 4.0, width / 2.0, height / 2.0], "X", 1.5, 6.0) - box_from_corners([length - 20.0, -1, -1], [length + 1.0, 2.5, height + 1.0]) - box_from_corners([length - 20.0, width - 2.5, -1], [length + 1.0, width + 1.0, height + 1.0])
