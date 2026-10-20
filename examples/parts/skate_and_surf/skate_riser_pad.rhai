// Skateboard riser pad: 1/4 inch (6.35 mm) thick, 75 x 60 mm with rounded corners, 5.5 mm holes for both new-school (54 x 41.3 mm) and old-school (63.5 x 41.3 mm) truck patterns
let t = 6.35; // [3.2, 12.7] Riser height (mm)
let length = 75.0; // [72.0, 90.0] Pad length (mm)
const width = 60.0;
let pad = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let pad = pad.fillet(8.0, pad.edges("|Z"));
let holes = [];
for sy in [-1.0, 1.0] {
    for x in [-27.0, 27.0, -31.75, 31.75] { holes.push(cylinder([x, sy * 20.65, -1.0], "Z", 2.75, t + 2.0)); }
}
pad - fuse_all(holes)
