// Ski pole basket: 60 mm (across corners) octagonal basket 4 mm thick with 8 open windows, a 12 mm hub bored 9 mm for the pole tip and eight 3 mm spokes
let dia = 60.0; // [45.0, 110.0] Basket diameter (mm)
let pole = 9.0; // [7.0, 12.0] Pole tip diameter (mm)
const t = 4.0;
let pts = [];
for i in 0..8 { let a = (22.5 + 45.0 * i.to_float()) * PI() / 180.0; pts.push([dia / 2.0 * cos(a), dia / 2.0 * sin(a), 0]); }
let rim = face(polygon(pts)).extrude([0, 0, t]);
let inner = face(polygon(pts)).extrude([0, 0, t + 2.0]).scale([0, 0, 0], 0.82).translate([0, 0, -1.0]);
let ring = rim - inner;
let spokes = [];
for i in 0..4 { spokes.push(box_centered(dia * 0.82, 3.0, t).translate([0, 0, t / 2.0]).rotate_z(i.to_float() * 45.0)); }
let hub = cylinder([0, 0, 0], "Z", pole / 2.0 + 3.0, 12.0);
ring + fuse_all(spokes) + hub - cylinder([0, 0, -1.0], "Z", pole / 2.0, 14.0)
