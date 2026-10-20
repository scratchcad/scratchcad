// A4 magazine file box: 80 mm wide, 245 mm deep, 300 mm tall at the back sloping to 110 mm at the front for A4 (210 x 297 mm) catalogues, 2.5 mm walls, 3 mm floor, 30 mm finger hole in the spine, label recess 60 x 30 mm
let width = 80.0; // [50.0, 120.0] Inside width (mm)
let depth = 245.0; // [225.0, 270.0] Inside depth (mm)
let back_h = 300.0; // [250.0, 330.0] Back height (mm)
let front_h = 110.0; // [60.0, 160.0] Front height (mm)
let wall = 2.5; // [2.0, 4.0] Wall (mm)

const floor_t = 3.0;
const slope_start = 0.45;
let ow = width + 2.0 * wall;
let od = depth + 2.0 * wall;
let profile = polygon([[0, 0, 0], [0, od, 0], [0, od, back_h], [0, od * slope_start, back_h], [0, 0, front_h]]);
let shell = profile.to_face().extrude([ow, 0, 0]);
let inner = box_from_corners([wall, wall, floor_t], [ow - wall, od - wall, back_h + 10.0]);
let file = shell - inner;
file = file - cylinder([ow / 2.0, od - wall - 1.0, back_h - 35.0], "Y", 15.0, wall + 2.0);
let lw = min(60.0, width - 10.0);
file - box_from_corners([ow / 2.0 - lw / 2.0, od - 0.8, back_h - 110.0], [ow / 2.0 + lw / 2.0, od + 1.0, back_h - 80.0])
