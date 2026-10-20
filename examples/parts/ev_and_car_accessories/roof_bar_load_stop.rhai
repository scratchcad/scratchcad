// Roof bar load stop: saddle over a 32 x 22 mm steel crossbar, 40 mm long, 5 mm walls, 50 mm tall upright stop with a strap slot 26 x 4 mm, M6 clamp screw boss (5 mm tap) in the side wall
let bar_w = 32.0; // [25.0, 40.0] Bar width (mm)
let bar_h = 22.0; // [18.0, 30.0] Bar height (mm)
let length = 40.0; // [30.0, 60.0] Saddle length along the bar (mm)
let wall = 5.0; // [4.0, 8.0] Wall (mm)
let stop_h = 50.0; // [30.0, 80.0] Upright height above the bar (mm)

const tap = 5.0;
let ow = bar_w + 2.0 * wall;
let saddle = box_from_corners([-length / 2.0, -ow / 2.0, 0], [length / 2.0, ow / 2.0, bar_h + wall]);
saddle = saddle.fillet(3.0, saddle.edges("|X and >Z"));
let upright = box_from_corners([-wall * 1.2, -ow / 2.0, bar_h + wall - 1.0], [wall * 1.2, ow / 2.0, bar_h + wall + stop_h]);
upright = upright.fillet(wall * 1.2 - 0.5, upright.edges("|Y and >Z"));
let gusset = polygon([[wall * 1.2 - 0.5, -ow / 2.0, bar_h + wall - 0.5], [length / 2.0, -ow / 2.0, bar_h + wall - 0.5], [wall * 1.2 - 0.5, -ow / 2.0, bar_h + wall + stop_h * 0.6]]).to_face().extrude([0, ow, 0]);
let boss = cylinder([0, ow / 2.0 - 1.0, bar_h / 2.0], "Y", 7.0, 6.0);
let stop = fuse_all([saddle, upright, gusset, boss]);
stop = stop - box_from_corners([-length, -bar_w / 2.0, -1.0], [length, bar_w / 2.0, bar_h]);
stop = stop - cylinder([0, 0, bar_h / 2.0], "Y", tap / 2.0, ow);
let sz = bar_h + wall + stop_h * 0.75;
stop - box_from_corners([-wall * 2.0, -13.0, sz - 2.0], [wall * 2.0, 13.0, sz + 2.0])
