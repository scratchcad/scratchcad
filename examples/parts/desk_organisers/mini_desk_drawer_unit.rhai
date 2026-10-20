// Mini desktop drawer unit, two bodies: 120 x 150 x 60 mm housing with 2.5 mm walls and an open front, and a drawer 0.5 mm smaller all round with 2 mm walls and a 30 x 12 mm pull, printed beside the housing
let width = 120.0; // [80.0, 200.0] Housing width (mm)
let depth = 150.0; // [100.0, 220.0] Housing depth (mm)
let height = 60.0; // [35.0, 100.0] Housing height (mm)
let wall = 2.5; // [2.0, 4.0] Housing wall (mm)
let clearance = 0.5; // [0.3, 1.0] Drawer clearance (mm)

const dwall = 2.0;
let housing = box_from_corners([0, 0, 0], [width, depth, height]);
housing = housing.fillet(3.0, housing.edges("|Y"));
housing = housing - box_from_corners([wall, -1.0, wall], [width - wall, depth - wall, height - wall]);
let dw = width - 2.0 * wall - 2.0 * clearance;
let dd = depth - wall - clearance;
let dh = height - 2.0 * wall - 2.0 * clearance;
let drawer = box_from_corners([0, 0, 0], [dw, dd, dh]) - box_from_corners([dwall, dwall, dwall], [dw - dwall, dd - dwall, dh + 1.0]);
let front = box_from_corners([-wall, -dwall, -wall], [dw + wall, 0.5, dh + wall]);
front = front.fillet(2.0, front.edges("|Y"));
let pull = box_from_corners([dw / 2.0 - 15.0, -dwall - 12.0, dh / 2.0 - 4.0], [dw / 2.0 + 15.0, -dwall + 0.5, dh / 2.0 + 4.0]);
pull = pull.fillet(3.9, pull.edges("|Z and <Y"));
drawer = fuse_all([drawer, front, pull]);
compound([housing, drawer.translate([width + 20.0 + wall, 14.0, wall])])
