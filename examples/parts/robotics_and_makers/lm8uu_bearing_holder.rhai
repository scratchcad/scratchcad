// Clamp housing for an LM8UU linear bearing (15 mm OD, 24 mm long): 21 mm tall block 34 mm wide, split clamp slot with M3 pinch screw, two M3 mounting ears 26 mm apart
let bearing_d = 15.0; // [10.0, 22.0] Bearing outside diameter (mm)
let bearing_len = 24.0; // [17.0, 45.0] Bearing length (mm)
let ear_spacing = 26.0; // [20.0, 40.0] Mounting hole spacing (mm)
const wall = 3.0;
let rb = bearing_d / 2.0;
let zc = rb + wall;
let w = bearing_d + 2.0 * wall;
let es = max(ear_spacing, w + 7.0);
let body = cylinder([0, -bearing_len / 2.0, zc], "Y", rb + wall, bearing_len) + box_from_corners([-rb - wall, -bearing_len / 2.0, 0], [rb + wall, bearing_len / 2.0, zc]);
let ears = box_from_corners([-es / 2.0 - 4.0, -bearing_len / 2.0, 0], [es / 2.0 + 4.0, bearing_len / 2.0, 4.0]);
let clamp = box_from_corners([-1.0, -bearing_len / 2.0, zc + rb - 1.0], [6.0, bearing_len / 2.0, zc + rb + wall + 5.0]);
clamp = box_from_corners([-4.0, -bearing_len / 2.0, zc], [4.0, bearing_len / 2.0, zc + rb + wall + 5.0]);
let h = fuse_all([body, ears, clamp]);
h -= cylinder([0, -bearing_len, zc], "Y", rb + 0.05, 2.0 * bearing_len);
h -= box_centered(1.5, bearing_len + 2.0, rb + wall + 6.0).translate([0, 0, zc + (rb + wall + 6.0) / 2.0]);
h -= cylinder([-6.0, 0, zc + rb + wall + 1.8], "X", 1.6, 12.0);
for s in [-1.0, 1.0] { h -= cylinder([s * es / 2.0, 0, -1], "Z", 1.6, 6.0); }
h.fillet(1.0, "|Y and >Z")
