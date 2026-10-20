// Universal joint yoke for a 16 mm cross: 32 mm hub, two ears 8 mm thick with 8 mm pin holes, 12 mm bore
let hub_d = 32.0; // [20.0, 60.0] Hub diameter (mm)
let hub_l = 20.0; // [10.0, 40.0] Hub length (mm)
let ear_t = 8.0; // [4.0, 15.0] Ear thickness (mm)
let ear_h = 26.0; // [15.0, 45.0] Ear height (mm)
let pin_d = 8.0; // [4.0, 16.0] Cross pin hole (mm)
let bore = 12.0; // [6.0, 30.0] Bore (mm)
let hub = cylinder(hub_d / 2.0, hub_l);
let span = hub_d - ear_t;
let ear = (box_from_corners([-ear_t / 2.0, -hub_d * 0.35, hub_l - 0.1], [ear_t / 2.0, hub_d * 0.35, hub_l + ear_h - hub_d * 0.35]) + cylinder([-ear_t / 2.0, 0, hub_l + ear_h - hub_d * 0.35], "X", hub_d * 0.35, ear_t));
let yoke = fuse_all([hub, ear.translate([span / 2.0, 0, 0]), ear.translate([-span / 2.0, 0, 0])]);
yoke - cylinder([-hub_d, 0, hub_l + ear_h - hub_d * 0.35], "X", pin_d / 2.0, hub_d * 2.0) - cylinder([0, 0, -1], "Z", bore / 2.0, hub_l * 0.8)
