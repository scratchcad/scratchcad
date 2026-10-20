// Plant pot with saucer: 120 mm tall frustum from 100 to 140 mm, 3 mm wall, rolled rim, five drain holes; 160 mm saucer 20 mm deep
let top = 140.0; // [80.0, 250.0] Rim diameter (mm)
let h = 120.0; // [60.0, 250.0] Pot height (mm)
let bottom = top * 0.72;
let pot = cone(bottom / 2.0, top / 2.0, h) - cone(bottom / 2.0 - 3.0 + 3.0 * (top - bottom) / (2.0 * h), top / 2.0 - 3.0 + (top - bottom) / (2.0 * h), h).translate([0, 0, 3.0]);
pot = pot + torus(top / 2.0 - 1.5, 3.0).translate([0, 0, h - 3.0]);
pot -= cylinder([0, 0, -1], "Z", 6.0, 5.0);
for k in 0..4 { pot -= cylinder([bottom * 0.3, 0, -1], "Z", 4.0, 5.0).rotate("Z", k.to_float() * 90.0); }
let saucer = cone(bottom / 2.0 + 10.0, bottom / 2.0 + 25.0, 20.0) - cone(bottom / 2.0 + 8.0, bottom / 2.0 + 23.0 - 0.0, 20.0).translate([0, 0, 2.0]);
compound([pot.translate([0, 0, 2.5]), saucer])
