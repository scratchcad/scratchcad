// Ice storage bin sliding door pull handle: 150 mm recessed pull 30 mm deep, 22 mm finger lip with 2.5 mm walls, two 4.5 mm screw holes at 130 mm centres
let length = 150.0; // [100.0, 220.0] Handle length (mm)
let depth = 30.0; // [20.0, 40.0] Handle depth (mm)
let lip = 22.0; // [15.0, 30.0] Finger lip height (mm)
const t = 2.5;
const base_h = 40.0;
let h = fuse_all([
    box_from_corners([0, 0, 0], [length, t, base_h]),
    box_from_corners([0, 0, base_h - t], [length, depth, base_h]),
    box_from_corners([0, depth - t, base_h - lip], [length, depth, base_h]),
]);
h = h + box_from_corners([0, 0, 0], [t, depth, base_h]) + box_from_corners([length - t, 0, 0], [length, depth, base_h]);
h - cylinder([10.0, -1.0, base_h / 3.0], "Y", 2.25, t + 2.0) - cylinder([length - 10.0, -1.0, base_h / 3.0], "Y", 2.25, t + 2.0)
