// V-belt pulley for an A (13 mm) belt, 100 mm pitch diameter, single groove 34 deg, 20 mm bore, 6 spokes
let pitch_d = 100.0; // [60.0, 250.0] Pitch diameter (mm)
let width = 20.0; // [16.0, 30.0] Rim width (mm)
let bore = 20.0; // [10.0, 40.0] Bore (mm)
let hub_d = 40.0; // [25.0, 70.0] Hub diameter (mm)
let hub_l = 35.0; // [20.0, 60.0] Hub length (mm)
let spokes = 6; // [3, 8] Spokes
let outer_r = pitch_d / 2.0 + 3.3;
let groove = sketch("XZ").move_to(pitch_d / 2.0 - 8.7, width / 2.0 - 4.95).line_to(outer_r + 1.0, width / 2.0 - 6.5).vline_to(width / 2.0 + 6.5).line_to(pitch_d / 2.0 - 8.7, width / 2.0 + 4.95).close().to_face().revolve("Z", 360);
let rim = cylinder(outer_r, width) - cylinder([0, 0, -1], "Z", outer_r - 14.0, width + 2.0) - groove;
let hub = cylinder([0, 0, width / 2.0 - hub_l / 2.0], "Z", hub_d / 2.0, hub_l);
let arms = [];
for i in 0..spokes { arms.push(box_from_corners([hub_d / 2.0 - 2.0, -4.0, width / 2.0 - 4.0], [outer_r - 12.0, 4.0, width / 2.0 + 4.0]).rotate_z(i.to_float() * 360.0 / spokes.to_float())); }
let p = fuse_all([rim, hub] + arms) - cylinder([0, 0, -50], "Z", bore / 2.0, 100);
p - box_from_corners([-3.0, 0, -50], [3.0, bore / 2.0 + 2.8, 50])
