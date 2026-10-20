// Plant label stake: 120 mm long, 18 mm wide, 1.5 mm thick, 45 x 25 mm label head, pointed tip
let length = 120.0; // [80.0, 200.0] Length (mm)
let width = 18.0; // [12.0, 25.0] Stake width (mm)
let thickness = 1.5; // [1.0, 3.0] Thickness (mm)
let head_w = 45.0; // [30.0, 70.0] Label width (mm)
let stake = polygon([[-width / 2.0, 25.0], [-width / 2.0, length - 30.0], [width / 2.0, length - 30.0], [width / 2.0, 25.0], [0, 0]]).to_face().extrude([0, 0, thickness]);
let head = box_from_corners([-head_w / 2.0, length - 30.0 - 0.01, 0], [head_w / 2.0, length, thickness]);
let h = head.fillet(4.0, head.edges("|Z"));
stake + h
