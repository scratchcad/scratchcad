// Follow focus hand wheel: 60 mm rim 12 mm wide with 30 grip flutes (2 mm radius), 4 mm web with five 10 mm lightening holes, 16 mm hub 15 mm long with a 6 mm D-shaft bore (5.5 mm across the flat) and an M3 set screw hole (2.5 mm)
let wheel_d = 60.0; // [40.0, 100.0] Wheel diameter (mm)
let rim_w = 12.0; // [8.0, 20.0] Rim width (mm)
let flutes = 30; // [12, 48] Number of grip flutes
const hub_d = 16.0;
const hub_len = 15.0;
const web = 4.0;
const rim_t = 5.0;
let r = wheel_d / 2.0;
let rim = cylinder([0, 0, 0], "Z", r, rim_w) - cylinder([0, 0, -1.0], "Z", r - rim_t, rim_w + 2.0);
let disc = cylinder([0, 0, 0], "Z", r - rim_t + 0.5, web);
let hub = cylinder([0, 0, 0], "Z", hub_d / 2.0, hub_len);
let wheel = rim + disc + hub;
let cuts = [];
for i in 0..flutes {
    let a = i.to_float() * 360.0 / flutes.to_float();
    cuts.push(cylinder([r + 0.8, 0, -1.0], "Z", 2.0, rim_w + 2.0).rotate_z(a));
}
let rh = (r - rim_t + hub_d / 2.0) / 2.0;
let lr = min(5.0, (r - rim_t - hub_d / 2.0) / 2.0 - 1.5);
for i in 0..5 {
    cuts.push(cylinder([rh, 0, -1.0], "Z", lr, web + 2.0).rotate_z(i.to_float() * 72.0));
}
let bore = cylinder([0, 0, -1.0], "Z", 3.05, hub_len + 2.0) - box_from_corners([2.5, -4.0, -2.0], [4.0, 4.0, hub_len + 3.0]);
let screw = cylinder([0, 0, hub_len - 5.0], "-X", 1.25, hub_d);
wheel - fuse_all(cuts) - bore - screw
