// Gate valve handwheel: 80 mm rim of 7 mm section, 4 spokes, 20 mm hub with a 9 mm square drive
let rim_d = 80.0; // [50.0, 200.0] Wheel diameter (mm)
let section = 7.0; // [4.0, 14.0] Rim section (mm)
let spokes = 4; // [3, 6] Spokes
let hub_d = 20.0; // [14.0, 40.0] Hub diameter (mm)
let square = 9.0; // [6.0, 16.0] Square drive (mm)
let rim = torus(rim_d / 2.0 - section / 2.0, section / 2.0);
let parts = [rim, cylinder([0, 0, -section], "Z", hub_d / 2.0, section * 1.6)];
for i in 0..spokes { parts.push(cylinder([hub_d / 2.0 - 1.0, 0, 0], "X", section * 0.35, rim_d / 2.0 - hub_d / 2.0 - section / 2.0 + 1.5).rotate_z(i.to_float() * 360.0 / spokes.to_float())); }
fuse_all(parts) - box_centered(square, square, section * 4.0)
