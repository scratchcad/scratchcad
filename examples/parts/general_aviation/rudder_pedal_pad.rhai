// Rudder pedal pad: 110 x 70 x 6 mm with 3 mm anti-slip ribs, 4 x 5 mm holes on 90 x 50 mm
let length = 110.0; // [80.0, 140.0] Pad length (mm)
let width = 70.0; // [50.0, 90.0] Pad width (mm)
let t = 6.0; // [4.0, 10.0] Thickness (mm)
let pad = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let p = pad.fillet(10.0, pad.edges("|Z"));
let ribs = [];
for k in 0..8 { ribs.push(box_centered(length - 30.0, 2.5, 4.0).translate([0, -width / 2.0 + 12.0 + k.to_float() * 6.5, t])); }
let holes = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * 45.0, sy * 25.0, -1], "Z", 2.5, t + 2.0)); } }
p - compound(ribs) - compound(holes)
