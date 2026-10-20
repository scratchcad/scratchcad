// A6 notepad tray with pen groove: pocket for a 105 x 148 mm pad 12 mm deep, 3 mm floor and walls, 16 mm round-bottomed pen groove along the right side, two thumb notches, 3 mm top edge round
let pad_w = 105.0; // [74.0, 148.0] Pad width (mm)
let pad_l = 148.0; // [105.0, 210.0] Pad length (mm)
let pocket = 12.0; // [6.0, 25.0] Pocket depth (mm)
let groove = 16.0; // [10.0, 22.0] Pen groove width (mm)
let wall = 3.0; // [2.0, 5.0] Wall (mm)

const floor_t = 3.0;
let iw = pad_w + 1.0;
let il = pad_l + 1.0;
let gw = groove + wall;
let w = iw + 2.0 * wall + gw;
let l = il + 2.0 * wall;
let h = pocket + floor_t;
let tray = box_from_corners([0, 0, 0], [w, l, h]);
tray = tray.fillet(6.0, tray.edges("|Z"));
tray = tray.fillet(min(3.0, wall - 0.5), tray.edges(">Z"));
tray = tray - box_from_corners([wall, wall, floor_t], [wall + iw, wall + il, h + 1.0]);
let gx = wall + iw + wall + groove / 2.0;
let gr = groove / 2.0;
let gz = max(floor_t + gr, h - gr + 2.0);
tray = tray - (cylinder([gx, wall + 6.0, gz], "Y", gr, l - 2.0 * wall - 12.0) + box_from_corners([gx - gr, wall + 6.0, gz], [gx + gr, l - wall - 6.0, h + 5.0]));
for y in [wall + il * 0.3, wall + il * 0.7] {
    tray = tray - cylinder([-1.0, y, h + 4.0], "X", 12.0, wall + 2.0);
}
tray
