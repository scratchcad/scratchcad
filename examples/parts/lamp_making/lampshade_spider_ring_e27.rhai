// Lampshade spider ring for E27: 200 mm shade ring 4 mm thick with three 3 mm spokes to a 40 mm reducer-ring hub with a 29 mm lampholder hole (straight spokes, flat)
let shade = 200.0; // [120.0, 300.0] Shade ring diameter (mm)
let hole = 29.0; // [28.0, 42.0] Lampholder hole (mm)
const t = 4.0;
let ring = cylinder([0, 0, 0], "Z", shade / 2.0, t) - cylinder([0, 0, -1.0], "Z", shade / 2.0 - 5.0, t + 2.0);
let hub = cylinder([0, 0, 0], "Z", hole / 2.0 + 6.0, t);
let spokes = [];
for i in 0..3 { spokes.push(box_from_corners([hole / 2.0 + 4.0, -1.5, 0], [shade / 2.0 - 3.0, 1.5, t]).rotate_z(i.to_float() * 120.0 + 90.0)); }
ring + hub + fuse_all(spokes) - cylinder([0, 0, -1.0], "Z", hole / 2.0, t + 2.0)
