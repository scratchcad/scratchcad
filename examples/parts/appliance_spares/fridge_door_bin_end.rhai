// Fridge door bin end cap: 110 x 80 mm side, 2.5 mm, 4 mm rail lip, 2 hooks for door bosses
let depth = 110.0; // [80.0, 140.0] Bin depth (mm)
let height = 80.0; // [50.0, 120.0] Bin height (mm)
let t = 2.5; // [2.0, 4.0] Wall (mm)
let side = polygon([[0, 0], [depth, 0], [depth, height * 0.6], [depth * 0.3, height], [0, height]]).to_face().extrude([0, 0, t]);
let lip = box_from_corners([0, 0, -4.0], [depth, t, 0.01]) + box_from_corners([0, 0, -4.0], [t, height, 0.01]);
let hooks = [];
for y in [height * 0.3, height * 0.8] { hooks.push(box_from_corners([-6.0, y - 3.0, 0], [0.01, y + 3.0, t]) + box_from_corners([-6.0, y - 3.0, 0], [-4.0, y + 3.0, 8.0])); }
side + lip + fuse_all(hooks)
