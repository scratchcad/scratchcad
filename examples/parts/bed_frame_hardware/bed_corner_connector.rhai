// Bed frame corner connector: L-shaped block joining two 20 x 50 mm side rails to a 50 mm post, 60 mm legs, 4 mm walls with 2 bolt holes per leg, braced by a corner gusset
let leg = 60.0; // [40.0, 90.0] Leg length (mm)
let rail_h = 50.0; // [40.0, 80.0] Rail height (mm)
const wall = 4.0;
let l = box_from_corners([0, 0, 0], [leg, wall, rail_h]) + box_from_corners([0, 0, 0], [wall, leg, rail_h]);
let gusset = face(polygon([[wall - 0.01, wall - 0.01, 0], [wall + 20.0, wall - 0.01, 0], [wall - 0.01, wall + 20.0, 0]])).extrude([0, 0, wall]);
let holes = [];
for d in [leg * 0.45, leg * 0.8] {
    holes.push(cylinder([d, -1.0, rail_h / 2.0], "Y", 3.0, wall + 2.0));
    holes.push(cylinder([-1.0, d, rail_h / 2.0], "X", 3.0, wall + 2.0));
}
l + gusset - fuse_all(holes)
