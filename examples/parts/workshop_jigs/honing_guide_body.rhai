// Side-clamp honing guide body: 60 x 35 x 20 mm, 4 mm blade slot 20 mm deep, M6 clamp screw hole, roller lugs with a 6 mm axle 12 mm below
let width = 60.0; // [40.0, 90.0] Guide width (mm)
let depth = 35.0; // [25.0, 50.0] Body depth (mm)
let height = 20.0; // [15.0, 30.0] Body height (mm)
let slot_h = 4.0; // [2.0, 8.0] Blade slot height (mm)
let axle_d = 6.0; // [4.0, 8.0] Roller axle diameter (mm)
let body = polygon([[0, 0, 0], [0, depth, 0], [0, depth, height * 0.6], [0, depth - 15.0, height], [0, 0, height]]).to_face().extrude([width, 0, 0]);
let lugs = [];
for x in [0.0, width - 8.0] { lugs.push(box_from_corners([x, 2.0, -12.0 - axle_d], [x + 8.0, 16.0, 0.5])); }
let slot = box_from_corners([-1, depth - 20.0, height * 0.35], [width + 1.0, depth + 1.0, height * 0.35 + slot_h]);
let screw = cylinder([width / 2.0, depth - 10.0, -1], "Z", 2.5, height + 2.0);
let axle = cylinder([-1, 9.0, -12.0], "X", axle_d / 2.0, width + 2.0);
body + fuse_all(lugs) - slot - screw - axle
