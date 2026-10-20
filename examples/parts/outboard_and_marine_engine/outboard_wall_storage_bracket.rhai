// Outboard motor wall storage bracket: 25 mm thick clamp board 250 mm wide and 120 mm tall carried on two 6 mm triangular side plates 200 mm tall with 250 mm wall flanges, each flange with three 8.5 mm wall bolt holes, board edges 2 mm chamfered
let board_w = 250.0; // [180.0, 350.0] Clamp board width (mm)
let board_h = 120.0; // [90.0, 180.0] Clamp board height (mm)
let standoff = 150.0; // [100.0, 250.0] Board distance from the wall (mm)
let board_t = 25.0; // [18.0, 40.0] Clamp board thickness (mm)
const plate_t = 6.0;
const plate_h = 200.0;
let x0 = -board_w / 2.0;
let board = box_from_corners([x0, standoff - board_t, plate_h - board_h], [-x0, standoff, plate_h]);
let board = board.chamfer(2.0);
let parts = [board];
let cuts = [];
for s in [-1.0, 1.0] {
    let x = s * (board_w / 2.0 + plate_t / 2.0);
    let side = face(polygon([[0, 0, 0], [0, standoff, plate_h - board_h], [0, standoff, plate_h], [0, 0, plate_h]])).extrude([plate_t, 0, 0]).translate([x - plate_t / 2.0, 0, 0]);
    let flange = box_from_corners([x - 30.0, -plate_t, 0], [x + 30.0, 0, plate_h + 50.0]);
    parts.push(side);
    parts.push(flange);
    for z in [30.0, plate_h / 2.0 + 25.0, plate_h + 20.0] {
        cuts.push(cylinder([x - s * 16.0, -plate_t - 1.0, z], "Y", 4.25, plate_t + 2.0));
    }
}
fuse_all(parts) - fuse_all(cuts)
