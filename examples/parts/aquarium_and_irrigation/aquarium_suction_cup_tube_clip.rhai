// Aquarium heater suction cup clip: 30 mm cup, 16 mm C-clip for 16 mm heater tube
let cup_d = 30.0; // [20.0, 45.0] Cup diameter (mm)
let tube_d = 16.0; // [8.0, 25.0] Tube diameter (mm)
let dome = 6.0; // [3.0, 10.0] Cup height (mm)
let R = (cup_d * cup_d / 4.0 + dome * dome) / (2.0 * dome);
let c = (sphere([0, 0, dome - R], R) - sphere([0, 0, dome - R], R - 1.5)) & box_from_corners([-cup_d, -cup_d, 0], [cup_d, cup_d, dome]);
let stem = cylinder([0, 0, dome - 1.0], "Z", 3.0, 14.0 - dome);
let clip_r = tube_d / 2.0;
let clip = cylinder([0, -6.0, 13.0 + clip_r + 1.6], "Y", clip_r + 2.0, 12.0) - cylinder([0, -7.0, 13.0 + clip_r + 1.6], "Y", clip_r, 14.0) - box_from_corners([-clip_r * 0.75, -7.0, 13.0 + clip_r + 1.6 + clip_r * 0.6], [clip_r * 0.75, 7.0, 13.0 + 2.0 * clip_r + 6.0]);
c + stem + clip
