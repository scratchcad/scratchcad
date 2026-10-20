// Sprayer boom hose clip: snaps a 13 mm feed hose to a 25 mm round boom tube, two C rings 12 mm wide with 3 mm walls back to back on a 5 mm web, each opening 70 percent of its bore away from the other
let hose_d = 13.0; // [8.0, 20.0] Hose diameter (mm)
let boom_d = 25.0; // [16.0, 40.0] Boom tube diameter (mm)
let width = 12.0; // [8.0, 20.0] Clip width (mm)
let wall = 3.0; // [2.0, 4.0] Wall thickness (mm)
const web = 5.0;
let rh = hose_d / 2.0;
let rt = boom_d / 2.0;
let yh = rt + wall + web + rh + wall;
let c_ring = |r, w, t, y, open_dir| {
    let ring = cylinder([0, y, 0], "Z", r + t, w) - cylinder([0, y, -1.0], "Z", r, w + 2.0);
    let o = r * 0.7;
    let y2 = y + open_dir * (r + t + 1.0);
    ring - box_from_corners([-o, min(y, y2), -1.0], [o, max(y, y2), w + 1.0])
};
let tube_ring = c_ring.call(rt, width, wall, 0.0, -1.0);
let hose_ring = c_ring.call(rh, width, wall, yh, 1.0);
let bridge = box_from_corners([-4.0, rt + 0.5 * wall, 0], [4.0, yh - rh - 0.5 * wall, width]);
fuse_all([tube_ring, hose_ring, bridge])
