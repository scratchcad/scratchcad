// Machine dust cover carry handle: 110 mm long arched grip 20 mm wide, 8 mm thick bar arching 25 mm above two 22 x 20 x 6 mm feet, each foot with a 4.5 mm screw hole
let length = 110.0; // [80.0, 160.0] Handle length (mm)
let rise = 25.0; // [18.0, 40.0] Grip height (mm)
let width = 20.0; // [16.0, 26.0] Handle width (mm)
let bar_t = 8.0; // [6.0, 12.0] Bar thickness (mm)
const foot_l = 22.0;
const foot_t = 6.0;
let l = length;
let profile = polygon([
    [0, 0, 0], [foot_l, 0, 0], [foot_l, 0, foot_t], [foot_l + 6.0, 0, rise], [l - foot_l - 6.0, 0, rise], [l - foot_l, 0, foot_t],
    [l - foot_l, 0, 0], [l, 0, 0], [l, 0, foot_t], [l - foot_l + bar_t * 0.5, 0, foot_t], [l - foot_l - 6.0 + bar_t * 0.3, 0, rise + bar_t],
    [foot_l + 6.0 - bar_t * 0.3, 0, rise + bar_t], [foot_l - bar_t * 0.5, 0, foot_t], [0, 0, foot_t]
]);
let handle = profile.to_face().extrude([0, width, 0]);
handle - fuse_all([
    cylinder([foot_l / 2.0 - 2.0, width / 2.0, -1.0], "Z", 2.25, foot_t + 2.0),
    cylinder([l - foot_l / 2.0 + 2.0, width / 2.0, -1.0], "Z", 2.25, foot_t + 2.0),
])
