// Workshop tyre lever: 120 mm long, 22 mm wide, 5 mm thick, tip tapering to 1.5 mm over the last 30 mm with a 3 mm upturn, 8 mm rounded corners, L-shaped spoke hook slot 3 mm wide at the handle end
let length = 120.0; // [90.0, 160.0] Lever length (mm)
let width = 22.0; // [16.0, 30.0] Lever width (mm)
let thickness = 5.0; // [3.5, 7.0] Lever thickness (mm)
let tip_len = 30.0; // [20.0, 40.0] Tip taper length (mm)
const tip_t = 1.5;
const upturn = 3.0;
let side = polygon([
    [0, 0, 0], [length - tip_len, 0, 0], [length, 0, upturn], [length, 0, upturn + tip_t],
    [length - tip_len, 0, thickness], [0, 0, thickness]
]).to_face().extrude([0, width, 0]);
let plan = box_from_corners([0, 0, -1.0], [length, width, thickness + upturn + 2.0]);
let plan = plan.fillet(min(8.0, width / 2.0 - 1.0), plan.edges("|Z"));
let lever = side & plan;
let hook = fuse_all([
    box_from_corners([12.0, -1.0, -1.0], [15.0, width / 2.0, thickness + 1.0]),
    box_from_corners([6.0, width / 2.0 - 3.0, -1.0], [15.0, width / 2.0, thickness + 1.0]),
]);
lever - hook
