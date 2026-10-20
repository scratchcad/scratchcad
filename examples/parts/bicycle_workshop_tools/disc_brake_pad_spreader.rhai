// Disc brake pad spreader: 90 mm long, 22 mm wide nylon wedge from a 2 mm tip to 8 mm over 30 mm, 11 mm rounded corners in plan, 14 mm finger hole in the handle
let length = 90.0; // [70.0, 120.0] Length (mm)
let width = 22.0; // [18.0, 30.0] Width (mm)
let tip_t = 2.0; // [1.5, 3.0] Tip thickness (mm)
let body_t = 8.0; // [5.0, 12.0] Handle thickness (mm)
const wedge_len = 30.0;
let side = polygon([[0, 0, 0], [length, 0, 0], [length, 0, body_t], [wedge_len, 0, body_t], [0, 0, tip_t]]).to_face().extrude([0, width, 0]).translate([0, -width / 2.0, 0]);
let plan = box_from_corners([0, -width / 2.0, -1.0], [length, width / 2.0, body_t + 1.0]);
let plan = plan.fillet(width / 2.0 - 0.5, plan.edges("|Z and >X"));
let plan = plan.fillet(3.0, plan.edges("|Z and <X"));
(side & plan) - cylinder([length - width / 2.0 - 2.0, 0, -1.0], "Z", 7.0, body_t + 2.0)
