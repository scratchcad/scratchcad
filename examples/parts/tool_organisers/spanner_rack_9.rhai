// Spanner rack for 9 combination spanners: 9 slanted slots 6 mm wide on a 22 mm pitch in a 210 x 50 x 20 mm block, slots 15 mm deep leaning back 15 degrees, with 2 keyhole hanging slots
let spanners = 9; // [4, 14] Number of spanners
let slot_w = 6.0; // [4.0, 9.0] Slot width (mm)
const pitch = 22.0;
const h = 20.0;
let length = pitch * spanners.to_float() + 12.0;
let b = box_from_corners([0, 0, 0], [length, 50.0, h]);
let cuts = [];
for i in 0..spanners { cuts.push(box_from_corners([0, -slot_w / 2.0, 0], [40.0, slot_w / 2.0, 30.0]).rotate_z(90.0).rotate_x(15.0).translate([6.0 + pitch * (i.to_float() + 0.5), 5.0, h - 15.0])); }
for x in [length * 0.25, length * 0.75] { cuts.push(cylinder([x, 51.0, h / 2.0], "Y", 4.0, 10.0).translate([0, -8.0, 0])); }
b - fuse_all(cuts)
