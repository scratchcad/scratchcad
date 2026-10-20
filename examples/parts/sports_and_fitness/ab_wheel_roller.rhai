// Ab exercise wheel: 180 mm wheel with a 60 mm wide rim 8 mm thick, three tread grooves, 6 mm central web with 6 lightening holes, 40 mm hub 60 mm wide on a 22.5 mm axle bore
let diameter = 180.0; // [140.0, 240.0] Wheel diameter (mm)
let tread_width = 60.0; // [30.0, 100.0] Tread width (mm)
let rim_t = 8.0; // [5.0, 15.0] Rim thickness (mm)
let hub_d = 40.0; // [30.0, 60.0] Hub diameter (mm)
let axle_d = 22.5; // [10.0, 30.0] Axle bore (mm)
let holes = 6; // [0, 10] Number of lightening holes
const web_t = 6.0;
let r = diameter / 2.0;
let w = tread_width;
let rim = cylinder([0, 0, -w / 2.0], "Z", r, w).fillet(6.0, "%CIRCLE") - cylinder([0, 0, -w / 2.0 - 1.0], "Z", r - rim_t, w + 2.0);
let web = cylinder([0, 0, -web_t / 2.0], "Z", r - rim_t + 0.5, web_t);
let hub = cylinder([0, 0, -w / 2.0], "Z", hub_d / 2.0, w);
let wheel = fuse_all([rim, web, hub]);
for k in [-1.0, 0.0, 1.0] {
    wheel = wheel - (cylinder([0, 0, k * w * 0.25 - 1.0], "Z", r + 1.0, 2.0) - cylinder([0, 0, k * w * 0.25 - 2.0], "Z", r - 1.5, 4.0));
}
let rr = (hub_d / 2.0 + r - rim_t) / 2.0;
let hr = min((r - rim_t - hub_d / 2.0) / 2.0 - 6.0, rr * (PI() / max(holes, 1).to_float()).sin() - 5.0);
for i in 0..holes {
    let a = i.to_float() * 2.0 * PI() / holes.to_float();
    wheel = wheel - cylinder([rr * a.cos(), rr * a.sin(), -web_t], "Z", hr, 2.0 * web_t);
}
wheel - cylinder([0, 0, -w], "Z", axle_d / 2.0, 2.0 * w)
