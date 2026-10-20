// Combine header pickup reel tine finger: clamp collar 14 mm wide and 5 mm thick for a 25.4 mm reel bat tube with a 3 mm split and a 12 mm ear holding a 6.5 mm clamp bolt hole, and a 10 mm thick finger 150 mm long tapering from 16 mm at the root to 7 mm at the tip, angled back 15 degrees from radial
let tube_d = 25.4; // [20.0, 34.0] Reel tube diameter (mm)
let finger_len = 150.0; // [90.0, 220.0] Finger length (mm)
let rake = 15.0; // [0.0, 30.0] Finger angle back from radial (degrees)
let root_w = 16.0; // [12.0, 22.0] Finger root width (mm)
const tip_w = 7.0;
const width = 14.0;
const wall = 5.0;
const ear = 12.0;
const finger_t = 10.0;
let ri = tube_d / 2.0;
let ro = ri + wall;
let collar = cylinder([0, 0, 0], "Z", ro, width);
let ears = box_from_corners([-ear / 2.0, ro - 2.0, 0], [ear / 2.0, ro + 10.0, width]);
let finger = polygon([[-root_w / 2.0, 0, 0], [root_w / 2.0, 0, 0], [tip_w / 2.0, finger_len, 0], [-tip_w / 2.0, finger_len, 0]]).to_face().extrude([0, 0, finger_t]);
let finger = finger.fillet(3.0, finger.edges("|Z and >Y")).translate([0, ro - 3.0, (width - finger_t) / 2.0]).rotate_z(180.0 - rake);
let body = fuse_all([collar, ears, finger]);
body - fuse_all([
    cylinder([0, 0, -1.0], "Z", ri, width + 2.0),
    box_from_corners([-1.5, 0, -1.0], [1.5, ro + 11.0, width + 1.0]),
    cylinder([-ear, ro + 5.0, width / 2.0], "X", 3.25, 2.0 * ear),
])
