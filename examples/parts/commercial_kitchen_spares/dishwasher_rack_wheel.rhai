// Commercial dishwasher rack roller wheel: 25 mm diameter tread 10 mm wide, 12 mm hub with a 4.2 mm axle bore, central web and 1 mm chamfered tread edges
let dia = 25.0; // [18.0, 35.0] Wheel diameter (mm)
let tread_w = 10.0; // [6.0, 14.0] Tread width (mm)
let bore = 4.2; // [3.0, 6.0] Axle bore (mm)
const hub_l = 12.0;
let rb = bore / 2.0;
let rh = rb + 2.0;
let r = dia / 2.0;
let rt = r - 2.5;
let z0 = hub_l / 2.0 - tread_w / 2.0;
let z1 = hub_l / 2.0 + tread_w / 2.0;
let pts = [[rb, 0], [rh, 0], [rh, hub_l / 2.0 - 1.5], [rt, hub_l / 2.0 - 1.5], [rt, z0], [r - 1.0, z0], [r, z0 + 1.0], [r, z1 - 1.0], [r - 1.0, z1], [rt, z1], [rt, hub_l / 2.0 + 1.5], [rh, hub_l / 2.0 + 1.5], [rh, hub_l], [rb, hub_l]];
let p3 = pts.map(|p| [p[0], 0, p[1]]);
face(polygon(p3)).revolve("Z", 360)
