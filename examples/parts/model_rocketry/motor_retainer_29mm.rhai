// 29 mm motor retainer: 37.5 mm body screws on a 38 mm aft ring, cap with 26 mm nozzle opening, knurl 24 ribs
let motor = 29.0; // [18.0, 54.0] Motor diameter (mm)
let body_d = 37.5; // [25.0, 65.0] Body diameter (mm)
let height = 15.0; // [10.0, 25.0] Height (mm)
let cap = cylinder(body_d / 2.0, height) - cylinder([0, 0, -1], "Z", body_d / 2.0 - 2.0, height - 2.0 + 1.0);
let ribs = [];
for k in 0..24 { ribs.push(box_centered(1.2, 1.2, height - 3.0).translate([body_d / 2.0, 0, (height - 3.0) / 2.0 + 0.5]).rotate_z(k.to_float() * 15.0)); }
cap - cylinder([0, 0, height - 3.0], "Z", motor / 2.0 - 1.5, 4.0) - compound(ribs)
