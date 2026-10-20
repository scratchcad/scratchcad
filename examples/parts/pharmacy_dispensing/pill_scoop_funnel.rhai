// Pill scoop with pouring spout: 60 mm wide flat scoop 50 mm long with 2 mm floor and walls 14 mm high, tapering over 30 mm (at least the width change, so the sides stay within 45 degrees) to an open 16 mm spout for pouring counted tablets into a vial, and a 70 mm handle 16 mm wide and 5 mm thick with an 8 mm rounded end
let width = 60.0; // [40.0, 90.0] Scoop width (mm)
let body_len = 50.0; // [30.0, 80.0] Scoop body length (mm)
let taper_len = 30.0; // [20.0, 50.0] Taper length (mm)
let spout_w = 16.0; // [12.0, 24.0] Spout width (mm)
let wall_h = 14.0; // [8.0, 25.0] Wall height (mm)
let handle_len = 70.0; // [40.0, 100.0] Handle length (mm)
const t = 2.0;
let a = width / 2.0;
let b = spout_w / 2.0;
let tl = max(taper_len, a - b);
let k = (a - b) / tl;
let sq = sqrt(1.0 + k * k);
let y_end = body_len + tl;
let outer = polygon([[-a, 0, 0], [a, 0, 0], [a, body_len, 0], [b, y_end, 0], [-b, y_end, 0], [-a, body_len, 0]]).to_face().extrude([0, 0, wall_h]);
let yc = body_len - t * (sq - 1.0) / k;
let xe = a - k * (tl + 1.0) - t * sq;
let inner = polygon([[-a + t, t, t], [a - t, t, t], [a - t, yc, t], [xe, y_end + 1.0, t], [-xe, y_end + 1.0, t], [-a + t, yc, t]]).to_face().extrude([0, 0, wall_h]);
let handle = box_from_corners([-8.0, -handle_len, 0], [8.0, 0.5, 5.0]);
let handle = handle.fillet(7.5, handle.edges("|Z and <Y"));
(outer + handle) - inner
