// Water rocket launch nozzle for PCO 1881 bottles: 28 mm cap 18 mm tall with Gardena-style 9 mm nozzle 25 mm
let cap_d = 30.0; // [28.0, 34.0] Cap outside diameter (mm)
let cap_h = 18.0; // [15.0, 22.0] Cap height (mm)
let nozzle = 9.0; // [6.0, 22.0] Nozzle bore (mm)
let cap = cylinder(cap_d / 2.0, cap_h) - cylinder([0, 0, 2.5], "Z", 12.5, cap_h);
let ribs = [];
for k in 0..30 { ribs.push(cylinder([cap_d / 2.0 + 0.2, 0, 2.0], "Z", 0.6, cap_h).rotate_z(k.to_float() * 12.0)); }
let tube = cylinder([0, 0, -25.0], "Z", nozzle / 2.0 + 2.0, 25.01) + cylinder([0, 0, -20.0], "Z", nozzle / 2.0 + 3.5, 3.0);
cap - compound(ribs) + tube - cylinder([0, 0, -26.0], "Z", nozzle / 2.0, 30.0)
