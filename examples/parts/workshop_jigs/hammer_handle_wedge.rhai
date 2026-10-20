// Hammer handle wedge: 40 mm long, 30 mm deep, tapering from 6 mm to 0.5 mm, with 0.5 mm chamfered top edges
let length = 40.0; // [20.0, 60.0] Wedge length across the eye (mm)
let depth = 30.0; // [15.0, 45.0] Wedge depth into the handle (mm)
let top_t = 6.0; // [3.0, 10.0] Top thickness (mm)
let tip_t = 0.5; // [0.3, 1.5] Tip thickness (mm)
let w = polygon([[0, -top_t / 2.0, depth], [0, -tip_t / 2.0, 0], [0, tip_t / 2.0, 0], [0, top_t / 2.0, depth]]).to_face().extrude([length, 0, 0]);
w.chamfer(0.5, w.edges(">Z"))
