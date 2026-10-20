// Raspberry Pi 4 Model B case base: 85 x 56 mm board, M2.5 holes 3.5 mm from the edges on 58 x 49 mm, 2 mm walls and floor, 3 mm standoffs, side cutouts for USB-C (x 3.5+7.7), 2 x micro HDMI (x 26, 39.5) and audio (x 54), open end for USB/Ethernet, 4 vent slots
let wall = 2.0; // [1.2, 3.0] Wall thickness (mm)
let floor_t = 2.0; // [1.2, 3.0] Floor thickness (mm)
let standoff = 3.0; // [2.0, 8.0] Standoff height (mm)
let height = 18.0; // [12.0, 30.0] Wall height (mm)
let clearance = 1.0; // [0.5, 2.0] Board clearance (mm)
let vents = 4; // [0, 8] Number of floor vent slots
const board_w = 85.0;
const board_h = 56.0;
let o = wall + clearance;
let w = board_w + 2.0 * o;
let d = board_h + 2.0 * o;
let h = max(height, floor_t + standoff + 9.0);
let outer = box(w, d, h);
let outer = outer.fillet(min(3.0, o - 0.1), outer.edges("|Z"));
let shell = outer - box_from_corners([wall, wall, floor_t], [w - wall, d - wall, h + 1.0]);
let parts = [shell];
let cuts = [];
for x in [3.5, 61.5] {
    for y in [3.5, 52.5] {
        parts.push(cylinder([o + x, o + y, floor_t - 0.5], "Z", 3.0, standoff + 0.5));
        cuts.push(cylinder([o + x, o + y, 1.0], "Z", 1.1, standoff + floor_t));
    }
}
let pcb = floor_t + standoff + 1.5;
for p in [[11.2, 9.5, 3.6], [26.0, 7.5, 3.6], [39.5, 7.5, 3.6], [54.0, 7.0, 6.5]] {
    cuts.push(box_from_corners([o + p[0] - p[1] / 2.0, -1, pcb - 0.5], [o + p[0] + p[1] / 2.0, wall + 1.0, pcb + p[2] + 0.5]));
}
cuts.push(box_from_corners([w - wall - 1.0, o + 2.0, pcb - 0.5], [w + 1.0, o + board_h - 2.0, h + 1.0]));
for k in 0..vents {
    let x = o + 20.0 + k.to_float() * 8.0;
    cuts.push(box_from_corners([x, o + 15.0, -1], [x + 3.0, o + board_h - 15.0, floor_t + 1.0]));
}
fuse_all(parts) - fuse_all(cuts)
