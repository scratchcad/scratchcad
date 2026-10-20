// LM7805 regulator in TO-220 bolted to a 1.5 mm aluminium angle heat sink 25 x 25 x 20 mm
let sink_l = 25.0; // [15.0, 40.0] Sink leg length (mm)
let sink_w = 20.0; // [12.0, 30.0] Sink width (mm)
let t = 1.5; // [1.0, 3.0] Sink thickness (mm)
let body = box_centered(10.0, 4.5, 9.2).translate([0, 2.25 + t, 4.6]);
let tab = box_centered(10.0, 1.3, 6.4).translate([0, t + 0.65, 9.2 + 3.2]) - cylinder([0, -5, 12.0], "Y", 1.8, 10);
let leads = [];
for x in [-2.54, 0.0, 2.54] { leads.push(box_centered(0.8, 0.5, 13.0).translate([x, 2.25 + t, -6.5])); }
let sink = box_from_corners([-sink_w / 2.0, 0, -2.0], [sink_w / 2.0, t, sink_l]) + box_from_corners([-sink_w / 2.0, -sink_l + t, -2.0], [sink_w / 2.0, t, -2.0 + t]);
fuse_all([body, tab, sink - cylinder([0, -5, 12.0], "Y", 1.6, 10)] + leads)
