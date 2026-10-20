// Camera tally light housing: 30 x 20 x 14 mm box with 1.6 mm walls and 2 mm rounded vertical edges, 10 mm round lens window on the front with a 12 mm x 1 mm recess inside for the diffuser, 3.5 mm cable entry at the back, open top with a 0.8 mm lid rebate, on a cold shoe foot (18.6 x 2 mm plate, 15 mm long, 12 mm neck)
let length = 30.0; // [24.0, 50.0] Housing length (mm)
let width = 20.0; // [18.0, 30.0] Housing width (mm)
let height = 14.0; // [10.0, 25.0] Housing height (mm)
let lens_d = 10.0; // [5.0, 12.0] Lens window diameter (mm)
const wall = 1.6;
const foot_h = 4.0;
let top = foot_h + height;
let shell = box_from_corners([-length / 2.0, -width / 2.0, foot_h], [length / 2.0, width / 2.0, top]);
let shell = shell.fillet(2.0, shell.edges("|Z"));
let cavity = box_from_corners([-length / 2.0 + wall, -width / 2.0 + wall, foot_h + wall], [length / 2.0 - wall, width / 2.0 - wall, top + 1.0]);
let rebate = box_from_corners([-length / 2.0 + wall / 2.0, -width / 2.0 + wall / 2.0, top - 1.0], [length / 2.0 - wall / 2.0, width / 2.0 - wall / 2.0, top + 1.0]);
let zc = foot_h + wall + (height - wall - 1.0) / 2.0;
let lr = min(lens_d / 2.0, (height - wall - 1.0) / 2.0 - 1.2);
let lens = cylinder([length / 2.0 + 1.0, 0, zc], "-X", lr, wall + 2.0);
let diffuser = cylinder([length / 2.0 - wall - 0.5, 0, zc], "X", lr + 1.0, 1.0);
let cable = cylinder([-length / 2.0 - 1.0, 0, zc], "X", 1.75, wall + 2.0);
let foot = box_from_corners([-7.5, -9.3, 0], [7.5, 9.3, 2.0]) + box_from_corners([-7.5, -6.0, 1.5], [7.5, 6.0, foot_h + 0.5]);
shell - cavity - rebate - lens - diffuser - cable + foot
