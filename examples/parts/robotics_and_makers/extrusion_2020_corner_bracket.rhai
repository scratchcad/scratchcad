// Cast corner bracket for 2020 aluminium extrusion: 20 mm wide, 20 x 20 mm legs 4 mm thick, diagonal web, 5.5 mm M5 holes centred on each leg, locating keys for the 6 mm slot
let leg = 20.0; // [15.0, 40.0] Leg length (mm)
let width = 20.0; // [15.0, 40.0] Bracket width (mm)
let t = 4.0; // [2.5, 6.0] Leg thickness (mm)
let hole_d = 5.5; // [3.4, 6.6] Bolt hole diameter (mm)
const key_w = 5.8;
let l = box(leg, width, t) + box(t, width, leg);
let web = polygon("XZ", [[t - 0.01, t - 0.01], [leg, t - 0.01], [leg, t + 1.5], [t + 1.5, leg], [t - 0.01, leg]]).to_face().extrude([0, 2.5, 0]).translate([0, width / 2.0 - 1.25, 0]);
let sides = [];
for y in [0.0, width - 2.0] { sides.push(polygon("XZ", [[t - 0.01, t - 0.01], [leg, t - 0.01], [t - 0.01, leg]]).to_face().extrude([0, 2.0, 0]).translate([0, y, 0])); }
let b = fuse_all([l, web] + sides);
let hc = (leg + t) / 2.0 + 1.0;
b -= cylinder([hc, width / 2.0, -1], "Z", hole_d / 2.0, t + 2.0) + cylinder([-1, width / 2.0, hc], "X", hole_d / 2.0, t + 2.0);
b -= cylinder([hc, width / 2.0, t], "Z", hole_d / 2.0 + 2.5, leg) + cylinder([t, width / 2.0, hc], "X", hole_d / 2.0 + 2.5, leg);
let keys = box_from_corners([t + 1.0, width / 2.0 - key_w / 2.0, -1.5], [leg - 1.0, width / 2.0 + key_w / 2.0, 0.01]) + box_from_corners([-1.5, width / 2.0 - key_w / 2.0, t + 1.0], [0.01, width / 2.0 + key_w / 2.0, leg - 1.0]);
keys -= cylinder([hc, width / 2.0, -2], "Z", hole_d / 2.0, 4.0) + cylinder([-2, width / 2.0, hc], "X", hole_d / 2.0, 4.0);
b + keys
