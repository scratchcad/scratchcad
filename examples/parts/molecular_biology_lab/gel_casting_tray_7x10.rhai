// Gel casting tray 7 x 10 cm: 70 x 100 mm floor 2 mm thick, open ends, 10 mm side walls 2 mm thick with two pairs of 2 mm comb slots 1 mm deep at 15 and 55 mm
let width = 70.0; // [50.0, 150.0] Gel width (mm)
let length = 100.0; // [70.0, 150.0] Gel length (mm)
const wall = 2.0;
let floor_ = box_from_corners([-wall, 0, 0], [width + wall, length, 2.0]);
let walls = box_from_corners([-wall, 0, 0], [0, length, 12.0]) + box_from_corners([width, 0, 0], [width + wall, length, 12.0]);
let slots = [];
for y in [15.0, 55.0] { slots.push(box_from_corners([-wall - 1.0, y, 11.0], [width + wall + 1.0, y + 2.0, 13.0])); }
floor_ + walls - fuse_all(slots)
