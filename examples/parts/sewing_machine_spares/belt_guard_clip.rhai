// Motor belt guard spring clip: C clip 3 mm thick that snaps over a 6 mm stud, 10 mm outside, 3.6 mm wide mouth, on a 20 x 10 x 2 mm tab with a 3.4 mm screw hole
let stud_d = 6.0; // [4.0, 8.0] Stud diameter (mm)
let clip_wall = 2.0; // [1.5, 3.0] Clip wall (mm)
let mouth = 3.6; // [2.5, 5.0] Mouth width (mm)
let tab_len = 20.0; // [16.0, 30.0] Tab length (mm)
const clip_h = 3.0;
const tab_t = 2.0;
let ri = stud_d / 2.0;
let ro = ri + clip_wall;
let m = min(mouth, stud_d - 0.8);
let ring = cylinder(ro, clip_h) - cylinder([0, 0, -1.0], "Z", ri, clip_h + 2.0) - box_from_corners([-m / 2.0, 0, -1.0], [m / 2.0, ro + 1.0, clip_h + 1.0]);
let tab = box_from_corners([-5.0, -ro - tab_len + 1.0, 0], [5.0, -ro + 0.5, tab_t]);
let tab = tab.fillet(4.0, tab.edges("|Z and <Y"));
(ring + tab) - cylinder([0, -ro - tab_len + 6.0, -1.0], "Z", 1.7, tab_t + 2.0)
