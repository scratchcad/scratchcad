// Screw-in electric fence ring insulator for wooden posts: 32 mm ring with a 20 mm eye, 7 mm thick, slit 3.5 mm at 45 degrees for threading the wire or tape in, on a 14 mm wide pad and 12 mm neck 8 mm long and an 18 mm collar 4 mm thick, over a 6 mm screw shank 35 mm long ending in a 10 mm point (thread not modelled)
let eye_d = 20.0; // [12.0, 30.0] Eye diameter (mm)
let ring_w = 6.0; // [4.0, 9.0] Ring band width (mm)
let ring_t = 7.0; // [5.0, 10.0] Ring thickness (mm)
let shank_len = 35.0; // [20.0, 60.0] Shank length (mm)
let shank_d = 6.0; // [4.0, 8.0] Shank diameter (mm)
const neck_d = 12.0;
const neck_len = 8.0;
const collar_d = 18.0;
const collar_t = 4.0;
const point = 10.0;
const slit = 3.5;
let re = eye_d / 2.0;
let ro = re + ring_w;
let zc = collar_t + neck_len + ro + 1.0;
let pad = box_from_corners([-neck_d / 2.0 - 1.0, -ring_t / 2.0, zc - ro - 1.0], [neck_d / 2.0 + 1.0, ring_t / 2.0, zc - re - 1.5]);
let ring = cylinder([0, -ring_t / 2.0, zc], "Y", ro, ring_t) - cylinder([0, -ring_t / 2.0 - 1.0, zc], "Y", re, ring_t + 2.0);
let gap = box_from_corners([-slit / 2.0, -ring_t, 0], [slit / 2.0, ring_t, ro + 2.0]).rotate([0, 0, 0], "Y", 45.0).translate([0, 0, zc]);
let ring = ring - gap;
let rs = shank_d / 2.0;
let tip = min(point, shank_len - 5.0);
fuse_all([
    ring,
    pad,
    cylinder([0, 0, collar_t - 0.5], "Z", neck_d / 2.0, neck_len + 1.0),
    cylinder(collar_d / 2.0, collar_t),
    cylinder([0, 0, -shank_len + tip], "Z", rs, shank_len - tip + 0.5),
    cone(0.4, rs, tip).translate([0, 0, -shank_len]),
])
