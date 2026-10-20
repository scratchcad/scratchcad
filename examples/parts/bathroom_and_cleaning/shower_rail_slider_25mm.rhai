// Shower riser rail slider for a 25 mm rail: 40 x 34 x 30 mm body, M6 clamp knob 24 mm, front cradle ring for a 24 mm handset handle with a 14 mm hose slot
let rail_d = 25.0; // [18.0, 32.0] Rail diameter (mm)
let body_h = 30.0; // [20.0, 40.0] Body height (mm)
let knob_d = 24.0; // [18.0, 32.0] Clamp knob diameter (mm)
let handle_d = 24.0; // [20.0, 30.0] Handle diameter (mm)
let rr = rail_d / 2.0 + 0.3;
let bw = rail_d + 15.0;
let body = box_centered(bw, rail_d + 9.0, body_h);
let b = body.fillet(4.0, body.edges("|Z"));
let knob = cylinder([bw / 2.0 - 0.5, 0, 0], "X", 5.0, 6.5) + cylinder([bw / 2.0 + 6.0, 0, 0], "X", knob_d / 2.0, 9.0);
let grips = [];
for i in 0..12 { grips.push(cylinder([bw / 2.0 + 5.0, 0, knob_d / 2.0 + 0.5], "X", 1.6, 11.0).rotate([0, 0, 0], "X", i.to_float() * 30.0)); }
let hr = handle_d / 2.0;
let ring_y = rail_d / 2.0 + 4.5 + 10.0 + hr;
let arm = box_from_corners([-7.0, rail_d / 2.0 + 3.0, -body_h / 2.0], [7.0, ring_y - hr - 1.5, -body_h / 2.0 + 14.0]);
let ring = cylinder([0, ring_y, -body_h / 2.0], "Z", hr + 3.5, 14.0) - cylinder([0, ring_y, -body_h / 2.0 - 1.0], "Z", hr, 16.0) - box_from_corners([-7.0, ring_y, -body_h], [7.0, ring_y + hr + 5.0, body_h]);
b + knob + arm + ring - fuse_all(grips) - cylinder([0, 0, -body_h], "Z", rr, 2.0 * body_h) - cylinder([0, 0, 0], "X", 2.5, bw / 2.0 + 20.0)
