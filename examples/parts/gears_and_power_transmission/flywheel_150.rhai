// Flywheel: 150 mm OD, 30 mm wide rim 15 mm deep, 10 mm web, 40 mm hub with 20 mm keyed bore
let outer_d = 150.0; // [80.0, 400.0] Outside diameter (mm)
let rim_w = 30.0; // [15.0, 48.0] Rim width (mm)
let rim_depth = 15.0; // [8.0, 40.0] Rim depth (mm)
let web_t = 10.0; // [5.0, 19.0] Web thickness (mm)
let hub_d = 40.0; // [25.0, 80.0] Hub diameter (mm)
let hub_l = 40.0; // [20.0, 80.0] Hub length (mm)
let bore = 20.0; // [10.0, 45.0] Bore (mm)
let profile = sketch("XZ").move_to(bore / 2.0, 0).hline_to(hub_d / 2.0).vline_to(rim_w / 2.0 - web_t / 2.0 - (hub_l - rim_w) / 2.0 + (hub_l - rim_w) / 2.0)
    .hline_to(outer_d / 2.0 - rim_depth).vline_to(-(rim_w - web_t) / 2.0 + (hub_l - rim_w) / 2.0)
    .hline_to(outer_d / 2.0).vline_to(rim_w + (hub_l - rim_w) / 2.0 - (rim_w - web_t) / 2.0)
    .hline_to(outer_d / 2.0 - rim_depth).vline_to((hub_l - rim_w) / 2.0 + (rim_w + web_t) / 2.0 - (rim_w - web_t) / 2.0 + 0.0)
    .hline_to(hub_d / 2.0).vline_to(hub_l).hline_to(bore / 2.0).close();
let wheel = profile.to_face().revolve("Z", 360);
wheel - box_from_corners([-3.0, 0, -1], [3.0, bore / 2.0 + 2.8, hub_l + 1])
