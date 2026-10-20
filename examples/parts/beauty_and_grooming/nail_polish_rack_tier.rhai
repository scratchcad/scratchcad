// Nail polish wall rack tier: 300 mm shelf 40 mm deep with a 15 mm front lip, 3 mm thick, 2 keyhole hangers
let length = 300.0; // [200.0, 450.0] Shelf length (mm)
let depth = 40.0; // [30.0, 60.0] Shelf depth (mm)
let lip = 15.0; // [8.0, 25.0] Front lip height (mm)
let t = 3.0; // [2.0, 4.0] Thickness (mm)
let shelf = box_from_corners([0, 0, 0], [length, depth, t]) + box_from_corners([0, depth - t, 0], [length, depth, lip]) + box_from_corners([0, 0, 0], [length, t, 60.0]);
let keys = [];
for x in [40.0, length - 40.0] { keys.push(cylinder([x, -1, 45.0], "Y", 4.0, t + 2.0) + box_from_corners([x - 2.0, -1, 45.0], [x + 2.0, t + 1.0, 53.0])); }
shelf - fuse_all(keys)
