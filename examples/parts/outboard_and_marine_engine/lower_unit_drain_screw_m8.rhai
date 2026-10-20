// Outboard lower unit gear oil drain screw M8: 14 mm head 4 mm thick with a 1.2 x 9 mm screwdriver slot 2 mm deep, a 13 mm sealing washer face 0.5 mm proud under it, a 10 mm plain M8 shank (8 mm, thread shown plain) with a 0.6 mm tip chamfer, and a 4 mm pocket 3 mm deep in the tip for the magnet
let head_d = 14.0; // [11.0, 20.0] Head diameter (mm)
let shank_len = 10.0; // [6.0, 16.0] Shank length (mm)
let thread_d = 8.0; // [6.0, 12.0] Thread diameter (mm)
const head_t = 4.0;
let rt = thread_d / 2.0;
let rh = max(head_d / 2.0, rt + 2.0);
let profile = polygon([
    [0, 0, 0], [rt - 0.6, 0, 0], [rt, 0, 0.6], [rt, 0, shank_len], [rh - 1.0, 0, shank_len], [rh - 1.0, 0, shank_len + 0.5],
    [rh, 0, shank_len + 0.5], [rh, 0, shank_len + 0.5 + head_t - 0.5], [rh - 0.5, 0, shank_len + 0.5 + head_t], [0, 0, shank_len + 0.5 + head_t]]);
let screw = face(profile).revolve("Z", 360.0);
let top = shank_len + 0.5 + head_t;
let slot = box_centered(1.2, 2.0 * rh + 2.0, 4.0).translate([0, 0, top]);
let pocket = cylinder([0, 0, -1.0], "Z", min(2.0, rt - 1.0), 4.0);
screw - slot - pocket
