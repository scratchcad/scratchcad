// 450 ohm ladder line spacer: 25 mm wire spacing for 1.6 mm wire, 35 x 8 x 4 mm with snap slots
let spacing = 25.0; // [15.0, 60.0] Wire spacing (mm)
let wire = 1.6; // [1.0, 3.0] Wire diameter (mm)
let t = 4.0; // [3.0, 6.0] Thickness (mm)
let s = box_centered(spacing + 10.0, 8.0, t).translate([0, 0, t / 2.0]);
let ss = s.fillet(3.9, s.edges("|Z"));
let cuts = [];
for sx in [-1.0, 1.0] { cuts.push(cylinder([sx * spacing / 2.0, 0, -1], "Z", wire / 2.0 + 0.05, t + 2.0) + box_from_corners([sx * spacing / 2.0 - wire * 0.35, 0, -1], [sx * spacing / 2.0 + wire * 0.35, 5.0, t + 1.0])); }
ss - fuse_all(cuts) - box_centered(spacing - 10.0, 3.0, t + 2.0).translate([0, 0, t / 2.0])
