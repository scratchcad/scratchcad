// CD jewel case, 142 x 125 x 10.4 mm closed: clear lid with a 1.3 mm face and 5 mm side walls, base tray 9 mm deep with 1.2 mm walls, 2.5 mm hinge pegs on the lid that snap into holes in the tray's hinge lugs, shown side by side
let length = 142.0; // [120.0, 160.0] Case length (mm)
let width = 125.0; // [110.0, 140.0] Case width (mm)
let tray_depth = 9.0; // [6.0, 12.0] Tray depth (mm)
let lid_wall = 5.0; // [3.0, 8.0] Lid side wall height (mm)
let wall = 1.2; // [0.8, 2.0] Wall thickness (mm)
let peg = 2.5; // [1.5, 3.5] Hinge peg diameter (mm)
// tray: open box, hinge lugs at the -X end
let tray = box_from_corners([0, 0, 0], [length, width, tray_depth]) - box_from_corners([wall, wall, wall], [length - wall, width - wall, tray_depth + 1.0]);
tray = tray - box_from_corners([-1.0, 8.0, tray_depth - 4.0], [wall + 1.0, width - 8.0, tray_depth + 1.0]);
let lug_z = tray_depth - 2.0;
let lugs = [];
for y in [wall, width - wall - 4.0] {
    lugs.push(box_from_corners([wall - 0.1, y, wall], [wall + 4.0, y + 4.0, tray_depth]));
}
tray = fuse_all([tray] + lugs);
tray = tray - cylinder([wall + 2.0, -1.0, lug_z], "Y", peg / 2.0 + 0.1, width + 2.0);
// lid: face plate with walls on three sides, open at the hinge end, pegs pointing outwards
let lid = box_from_corners([0, 0, 0], [length, width + 2.0 * wall + 0.4, 1.3]);
lid = lid + box_from_corners([0, 0, 1.2], [length, wall, lid_wall]) + box_from_corners([0, width + wall + 0.4, 1.2], [length, width + 2.0 * wall + 0.4, lid_wall]) + box_from_corners([length - wall, 0, 1.2], [length, width + 2.0 * wall + 0.4, lid_wall]);
lid = lid + cylinder([wall + 2.0, -2.0, lid_wall - 1.5], "Y", peg / 2.0, 2.1) + cylinder([wall + 2.0, width + 2.0 * wall + 0.3, lid_wall - 1.5], "Y", peg / 2.0, 2.1);
[tray, lid.translate([0, width + 20.0, 0])]
