// Wall saddle rack: 300 mm arm, 60 mm wide inverted-V saddle bar 3 mm, wall plate 150 x 60 mm with 4 holes
let arm = 300.0; // [200.0, 450.0] Arm length (mm)
let width = 60.0; // [40.0, 90.0] Saddle width (mm)
let t = 3.0; // [2.0, 5.0] Sheet thickness (mm)
let plate = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, t, 150.0]);
let ridge = polygon([[-width / 2.0, 0, 120.0], [width / 2.0, 0, 120.0], [0, 0, 145.0]]).to_face().extrude([0, arm, 0]) - polygon([[-width / 2.0 + t, -1, 120.0], [width / 2.0 - t, -1, 120.0], [0, -1, 145.0 - t * 1.5]]).to_face().extrude([0, arm + 2.0, 0]);
let brace = polygon([[0, t - 0.01, 10.0], [0, t - 0.01, 121.0], [0, arm * 0.6, 121.0]]).to_face().extrude([t, 0, 0]).translate([-t / 2.0, 0, 0]);
let holes = [];
for x in [-15.0, 15.0] { for z in [20.0, 100.0] { holes.push(cylinder([x, -1, z], "Y", 2.5, t + 2.0)); } }
plate + ridge + brace - compound(holes)
