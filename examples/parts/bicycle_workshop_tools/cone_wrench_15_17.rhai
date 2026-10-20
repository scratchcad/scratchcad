// Double-ended hub cone wrench: 2 mm thick, 15 mm opening at one end and 17 mm at the other, heads 2.1 x the opening wide, 180 mm long with a 14 mm wide handle and a 6 mm hang hole
let jaw_a = 15.0; // [13.0, 19.0] First opening (mm)
let jaw_b = 17.0; // [13.0, 19.0] Second opening (mm)
let length = 180.0; // [140.0, 220.0] Length over the heads (mm)
let thickness = 2.0; // [1.5, 3.0] Thickness (mm)
const handle_w = 14.0;
let ra = jaw_a * 1.05;
let rb = jaw_b * 1.05;
let xa = ra;
let xb = length - rb;
let blank = fuse_all([
    cylinder([xa, 0, 0], "Z", ra, thickness),
    cylinder([xb, 0, 0], "Z", rb, thickness),
    box_from_corners([xa, -handle_w / 2.0, 0], [xb, handle_w / 2.0, thickness]),
]);
let cuts = fuse_all([
    box_from_corners([-1.0, -jaw_a / 2.0, -1.0], [xa, jaw_a / 2.0, thickness + 1.0]),
    cylinder([xa, 0, -1.0], "Z", jaw_a / 2.0, thickness + 2.0),
    box_from_corners([xb, -jaw_b / 2.0, -1.0], [length + 1.0, jaw_b / 2.0, thickness + 1.0]),
    cylinder([xb, 0, -1.0], "Z", jaw_b / 2.0, thickness + 2.0),
    cylinder([length / 2.0, 0, -1.0], "Z", 3.0, thickness + 2.0),
]);
blank - cuts
