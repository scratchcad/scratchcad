// Swimming lane rope float disc: 100 mm disc 20 mm thick with 12 radial wave-breaker fins 3 mm thick, a 14 mm cable bore and a 30 mm hub
let dia = 100.0; // [80.0, 150.0] Disc diameter (mm)
let fins = 12; // [6, 20] Number of fins
const t = 20.0;
let hub = cylinder([0, 0, 0], "Z", 15.0, t);
let rim = cylinder([0, 0, t / 2.0 - 2.0], "Z", dia / 2.0, 4.0) - cylinder([0, 0, 0], "Z", dia / 2.0 - 4.0, t);
let f = [];
for i in 0..fins { f.push(box_from_corners([14.0, -1.5, 0], [dia / 2.0 - 2.0, 1.5, t]).rotate_z(i.to_float() * 360.0 / fins.to_float())); }
hub + rim + fuse_all(f) - cylinder([0, 0, -1.0], "Z", 7.0, t + 2.0)
