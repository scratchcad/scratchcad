// Pedal wrench: 360 mm long, 4 mm thick steel, 15 mm jaws at both ends angled 30 and 45 degrees to the handle, 34 mm heads, 24 mm wide handle with a 10 mm hang hole
let jaw = 15.0; // [14.0, 16.0] Jaw opening (mm)
let length = 360.0; // [250.0, 420.0] Length between head centres (mm)
let thickness = 4.0; // [3.0, 6.0] Thickness (mm)
let angle_a = 30.0; // [0.0, 45.0] First jaw angle (degrees)
let angle_b = 45.0; // [0.0, 45.0] Second jaw angle (degrees)
const handle_w = 24.0;
let rh = jaw * 1.15;
let blank = fuse_all([
    cylinder([0, 0, 0], "Z", rh, thickness),
    cylinder([length, 0, 0], "Z", rh, thickness),
    box_from_corners([0, -handle_w / 2.0, 0], [length, handle_w / 2.0, thickness]),
]);
let jaw_a = (box_from_corners([-3.0 * rh, -jaw / 2.0, -1.0], [0, jaw / 2.0, thickness + 1.0]) + cylinder([0, 0, -1.0], "Z", jaw / 2.0, thickness + 2.0)).rotate_z(-angle_a);
let jaw_b = (box_from_corners([0, -jaw / 2.0, -1.0], [3.0 * rh, jaw / 2.0, thickness + 1.0]) + cylinder([0, 0, -1.0], "Z", jaw / 2.0, thickness + 2.0)).rotate_z(angle_b).translate([length, 0, 0]);
blank - fuse_all([jaw_a, jaw_b, cylinder([length - 40.0, 0, -1.0], "Z", 5.0, thickness + 2.0)])
