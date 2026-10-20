// Garden hose hanger: 180 mm arched saddle (90 mm radius) 3 mm thick projecting 120 mm, wall plate with 3 keyholes, 25 mm front lip
let radius = 90.0; // [60.0, 120.0] Saddle radius (mm)
let depth = 120.0; // [80.0, 180.0] Projection from the wall (mm)
let t = 3.0; // [2.0, 5.0] Thickness (mm)
let arch = (cylinder([0, 0, 0], "Y", radius, depth) - cylinder([0, -1, 0], "Y", radius - t, depth + 2.0)) & box_from_corners([-radius - 1.0, -1, 0], [radius + 1.0, depth + 1.0, radius + 1.0]);
let lip = (cylinder([0, depth - t, 0], "Y", radius + 25.0, t) - cylinder([0, depth - t - 1.0, 0], "Y", radius - t, t + 2.0)) & box_from_corners([-radius - 30.0, depth - t - 1.0, 0], [radius + 30.0, depth + 1.0, radius + 30.0]);
let plate = box_from_corners([-40.0, -t, -30.0], [40.0, 0, radius + 10.0]);
let keys = [];
for z in [-15.0, 40.0, radius - 5.0] { keys.push(cylinder([0, -t - 1.0, z], "Y", 4.0, t + 2.0) + box_from_corners([-2.0, -t - 1.0, z], [2.0, 1.0, z + 8.0])); }
arch + lip + plate - fuse_all(keys)
