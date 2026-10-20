// T-shaped plant label stake: 60 x 30 mm writing head, 120 mm stake 12 mm wide tapering to a point, 1.2 mm thick with a stiffening rib
let head_width = 60.0; // [30.0, 100.0] Label width (mm)
let head_height = 30.0; // [15.0, 60.0] Label height (mm)
let stake_length = 120.0; // [50.0, 250.0] Stake length (mm)
let stake_width = 12.0; // [6.0, 20.0] Stake width (mm)
let thickness = 1.2; // [0.8, 3.0] Thickness (mm)
let hw = head_width / 2.0;
let sw = stake_width / 2.0;
let outline = polygon([[-sw, 0], [-sw, -stake_length + 15.0], [0, -stake_length], [sw, -stake_length + 15.0], [sw, 0],
                       [hw, 0], [hw, head_height], [-hw, head_height], [-hw, 0]]);
let plate = outline.to_face().extrude(thickness).fillet(4.0, "|Z and >Y");
let rib = box_from_corners([-0.8, -stake_length + 25.0, thickness - 0.1], [0.8, -2.0, thickness + 1.2]);
let gusset = polygon([[-sw, 0], [sw, 0], [0, -8.0]]).to_face().extrude(thickness + 1.2);
fuse_all([plate, rib, gusset])
