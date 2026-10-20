// Ladder storage hook: 300 mm deep L-hook, 40 x 4 mm flat bar, 60 mm upturn, plate 40 x 120 mm with 3 holes
let reach = 300.0; // [150.0, 450.0] Hook reach (mm)
let up = 60.0; // [30.0, 100.0] Upturn height (mm)
let w = 40.0; // [25.0, 60.0] Bar width (mm)
let t = 4.0; // [3.0, 6.0] Bar thickness (mm)
let plate = box_from_corners([-w / 2.0, 0, -60.0], [w / 2.0, t, 60.0]);
let arm = box_from_corners([-w / 2.0, t - 0.01, -t], [w / 2.0, reach, 0]);
let lip = box_from_corners([-w / 2.0, reach - t, -t], [w / 2.0, reach, up]);
let gusset = polygon([[0, t - 0.01, -50.0], [0, t - 0.01, -t + 0.01], [0, 80.0, -t + 0.01]]).to_face().extrude([t, 0, 0]).translate([-t / 2.0, 0, 0]);
let holes = [];
for z in [-45.0, 20.0, 45.0] { holes.push(cylinder([0, -1, z], "Y", 2.75, t + 2.0)); }
plate + arm + lip + gusset - compound(holes)
