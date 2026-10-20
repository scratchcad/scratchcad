// Clip-on heatsink cooling shroud for an E3D V6 hotend: 32 x 30 x 26 mm block around the 22.3 mm heatsink, 16 mm open slot at the back to snap on, 30 mm fan face with a 28 mm duct opening and 4 x M3 pilot holes 2.8 mm on 24 mm, 8 mm deep
let heatsink = 22.3; // [16.0, 25.0] Heatsink diameter (mm)
let height = 26.0; // [20.0, 35.0] Shroud height (mm)
let fan = 30.0; // [25.0, 40.0] Fan size (mm)
let slot = 16.0; // [10.0, 20.0] Snap-on slot width (mm)
const front = 4.0;
let r = heatsink / 2.0;
let width = max(fan + 2.0, heatsink + 8.0);
let yf = -r - front - 2.0;
let yb = r + 3.0;
let block = box_from_corners([-width / 2.0, yf, 0], [width / 2.0, yb, height]);
block = block.fillet(2.0, "|Y");
let sw = min(slot, heatsink - 3.0);
let hp = fan * 0.8;
let zc = height / 2.0;
let cuts = [
    cylinder([0, 0, -1], "Z", r, height + 2.0),
    box_from_corners([-sw / 2.0, 0, -1], [sw / 2.0, yb + 1.0, height + 1.0]),
    cylinder([0, yf - 1.0, zc], "Y", min(fan * 0.47, height / 2.0 - 1.0), -yf + 1.0)
];
for sx in [-1.0, 1.0] {
    for sz in [-1.0, 1.0] {
        cuts.push(cylinder([sx * hp / 2.0, yf - 1.0, zc + sz * min(hp / 2.0, height / 2.0 - 2.0)], "Y", 1.4, 9.0));
    }
}
block - fuse_all(cuts)
