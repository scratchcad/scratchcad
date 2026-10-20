// Kart brake pedal stop: split clamp for a 28 mm chassis tube, 20 mm wide with 7 mm walls, 12 x 12 mm clamping lugs with an M6 screw hole (6.4 mm) across a 2 mm gap, and a 20 x 14 mm stop block on top with an M8 tapped hole (6.8 mm core) for the adjustable stop bolt
let tube_d = 28.0; // [20.0, 35.0] Chassis tube diameter (mm)
let width = 20.0; // [15.0, 30.0] Clamp width (mm)
let stop_h = 14.0; // [10.0, 25.0] Stop block height (mm)
const wall = 7.0;
let ri = tube_d / 2.0 + 0.2;
let ro = ri + wall;
let ring = cylinder([0, 0, 0], "X", ro, width);
let lugs = box_from_corners([0, -6.0, -ro - 12.0], [width, 6.0, -ri]);
let block = box_from_corners([0, -10.0, ro - 2.0], [width, 10.0, ro + stop_h]);
let body = ring + lugs + block;
let cuts = [
    cylinder([-1.0, 0, 0], "X", ri, width + 2.0),
    box_from_corners([-1.0, -1.0, -ro - 13.0], [width + 1.0, 1.0, -ri + 1.0]),
    cylinder([width / 2.0, -10.0, -ro - 6.0], "Y", 3.2, 20.0),
    cylinder([width / 2.0, -11.0, ro + stop_h / 2.0], "Y", 3.4, 22.0)
];
body - fuse_all(cuts)
