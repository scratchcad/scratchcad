// Dispensary drawer divider: 2 mm plate 150 mm long and 55 mm high with 10 mm rounded top corners, two 6 x 3 mm locating tabs under the bottom edge 20 mm from each end, a 30 x 14 mm finger cut-out centred on the top edge, and a 40 x 12 mm label recess 0.6 mm deep near the top
let length = 150.0; // [80.0, 250.0] Divider length (mm)
let height = 55.0; // [35.0, 90.0] Divider height (mm)
let thickness = 2.0; // [1.5, 3.0] Plate thickness (mm)
let finger_w = 30.0; // [20.0, 40.0] Finger cut-out width (mm)
const tab_w = 6.0;
const tab_h = 3.0;
const finger_d = 14.0;
let plate = box_from_corners([0, 0, 0], [length, thickness, height]);
let plate = plate.fillet(10.0, plate.edges("|Y and >Z"));
let parts = [
    plate,
    box_from_corners([20.0 - tab_w / 2.0, 0, -tab_h], [20.0 + tab_w / 2.0, thickness, 0.5]),
    box_from_corners([length - 20.0 - tab_w / 2.0, 0, -tab_h], [length - 20.0 + tab_w / 2.0, thickness, 0.5]),
];
let fr = finger_d / 2.0;
let fw = min(finger_w, length - 50.0);
let cx = length / 2.0;
let cut = fuse_all([
    box_from_corners([cx - fw / 2.0 + fr, -1.0, height - finger_d], [cx + fw / 2.0 - fr, thickness + 1.0, height + 1.0]),
    box_from_corners([cx - fw / 2.0, -1.0, height - fr], [cx + fw / 2.0, thickness + 1.0, height + 1.0]),
    cylinder([cx - fw / 2.0 + fr, -1.0, height - fr], "Y", fr, thickness + 2.0),
    cylinder([cx + fw / 2.0 - fr, -1.0, height - fr], "Y", fr, thickness + 2.0),
]);
const label_x = 15.0;
let label = box_from_corners([label_x, -1.0, height - 30.0], [label_x + 40.0, 0.6, height - 18.0]);
fuse_all(parts) - fuse_all([cut, label])
