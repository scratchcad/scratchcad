// Fibre splice protector holder: 60 x 30 x 6 mm insert with 12 slots 3.2 mm wide 4 mm deep for 60 mm heat-shrink splice sleeves, on a 3.5 mm pitch
let slots = 12; // [6, 24] Number of splice slots
let slot_w = 3.2; // [2.5, 4.0] Splice sleeve width (mm)
const pitch = 3.5;
let w = pitch * slots.to_float() + 4.0;
let b = box_centered(60.0, w, 6.0).translate([0, 0, 3.0]);
let cuts = [];
for i in 0..slots { cuts.push(box_centered(62.0, slot_w, 5.0).translate([0, -w / 2.0 + 2.0 + pitch * (i.to_float() + 0.5), 6.0 - 4.0 + 2.5])); }
b - fuse_all(cuts)
