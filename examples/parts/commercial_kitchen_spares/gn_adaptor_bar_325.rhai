// Gastronorm adaptor bar: 325 mm cross bar for GN 1/1 openings, 25 mm wide top 1.5 mm thick with 8 mm folded skirts and 20 mm notched ends that hook over the counter frame
let length = 325.0; // [265.0, 530.0] Bar length (mm)
let width = 25.0; // [18.0, 35.0] Bar width (mm)
let skirt = 8.0; // [5.0, 15.0] Skirt depth (mm)
const t = 1.5;
const notch = 20.0;
let bar = fuse_all([
    box_from_corners([0, 0, 0], [length, width, t]),
    box_from_corners([0, 0, -skirt], [length, t, t]),
    box_from_corners([0, width - t, -skirt], [length, width, t]),
]);
bar - box_from_corners([-1.0, -1.0, -skirt - 1.0], [notch, width + 1.0, -0.001]) - box_from_corners([length - notch, -1.0, -skirt - 1.0], [length + 1.0, width + 1.0, -0.001])
