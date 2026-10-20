// Prep table undershelf support clip: 3 mm half-collar for a 41 mm tube leg, 40 mm tall, with a 30 mm ledge at the bottom for the shelf corner gusset and an M8 clamping screw boss (6.8 mm tap)
let leg_d = 41.3; // [32.0, 50.0] Leg tube diameter (mm)
let height = 40.0; // [25.0, 60.0] Clip height (mm)
let ledge = 30.0; // [20.0, 40.0] Ledge depth (mm)
const t = 4.0;
let ri = leg_d / 2.0 + 0.2;
let ro = ri + t;
let collar = cylinder([0, 0, 0], "Z", ro, height) - cylinder([0, 0, -1.0], "Z", ri, height + 2.0);
collar = collar - box_from_corners([-ro - 1.0, -ro - 1.0, -1.0], [0, ro + 1.0, height + 1.0]);
let ears = box_from_corners([-12.0, ri, 0], [0.01, ro + 0.5, height]) + box_from_corners([-12.0, -ro - 0.5, 0], [0.01, -ri, height]);
let shelf = box_from_corners([ri, -ledge / 2.0, 0], [ri + ledge, ledge / 2.0, t]);
let boss = cylinder([ro - 1.0, 0, height / 2.0], "X", 7.0, 8.0);
let c = collar + ears + shelf + boss;
c - cylinder([ri - 2.0, 0, height / 2.0], "X", 3.4, 14.0) - cylinder([-6.0, -ro - 2.0, height / 2.0], "Y", 2.75, 2.0 * ro + 4.0)
