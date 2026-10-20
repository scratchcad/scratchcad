// Grow light bar hanger clip for a 25 mm tent rod: 4 mm C clip 15 mm wide that snaps over the rod through a 20 mm top opening, a 6 x 15 mm stem 25 mm long, and a 16 mm eye with an 8 mm hole for a carabiner or rope ratchet hook
let rod_d = 25.0; // [16.0, 32.0] Rod diameter (mm)
let stem_len = 25.0; // [10.0, 50.0] Stem length (mm)
let width = 15.0; // [10.0, 25.0] Clip width (mm)
let eye_hole = 8.0; // [5.0, 12.0] Eye hole diameter (mm)
const wall = 4.0;
let ri = rod_d / 2.0 + 0.2;
let ro = ri + wall;
let gw = rod_d * 0.8;
let ring = cylinder([0, 0, 0], "Y", ro, width) - cylinder([0, -1.0, 0], "Y", ri, width + 2.0);
let clip = ring - box_from_corners([-gw / 2.0, -1.0, 0], [gw / 2.0, width + 1.0, ro + 1.0]);
let er = eye_hole / 2.0 + 4.0;
let ez = -ro - stem_len;
let stem = box_from_corners([-3.0, 0, ez], [3.0, width, -ri - 0.5]);
let eye = cylinder([0, 0, ez], "Y", er, width) - cylinder([0, -1.0, ez], "Y", eye_hole / 2.0, width + 2.0);
let body = fuse_all([clip, stem, eye]);
(body - cylinder([0, -1.0, 0], "Y", ri, width + 2.0)).translate([0, -width / 2.0, 0])
