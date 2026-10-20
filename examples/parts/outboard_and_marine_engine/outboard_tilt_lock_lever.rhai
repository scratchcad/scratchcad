// Outboard tilt lock lever: 6 mm thick lever 70 mm long, 20 mm hub boss 10 mm thick with an 8.2 mm bore and a 7 mm double-D flat, arm tapering from 14 mm to 10 mm, and a 16 mm thumb pad at the end with 2 mm rounded edges
let length = 70.0; // [45.0, 110.0] Lever length (mm)
let thickness = 6.0; // [4.0, 10.0] Lever thickness (mm)
let shaft_d = 8.2; // [6.0, 12.0] Shaft diameter (mm)
const hub_d = 20.0;
const hub_t = 10.0;
let arm = face(polygon([[0, -7.0, 0], [length, -5.0, 0], [length, 5.0, 0], [0, 7.0, 0]])).extrude([0, 0, thickness]);
let pad = cylinder([length, 0, 0], "Z", 8.0, thickness);
let pad = pad.fillet(min(2.0, thickness / 2.0 - 0.5), pad.edges(">Z"));
let hub = cylinder([0, 0, 0], "Z", max(hub_d / 2.0, shaft_d / 2.0 + 4.0), hub_t);
let body = fuse_all([arm, pad, hub]);
let bore = cylinder([0, 0, -1.0], "Z", shaft_d / 2.0, hub_t + 2.0) & box_centered(shaft_d * 0.85, shaft_d + 2.0, hub_t + 4.0).translate([0, 0, hub_t / 2.0]);
body - bore
