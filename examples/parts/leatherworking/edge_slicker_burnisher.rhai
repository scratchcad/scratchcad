// Leather edge slicker: 100 mm spindle, 3 grooves 2.5, 4 and 6 mm wide on 30 mm drum, 8 mm drill shank 30 mm
let drum = 30.0; // [20.0, 40.0] Drum diameter (mm)
let shank = 8.0; // [6.0, 10.0] Shank diameter (mm)
let body = cylinder(drum / 2.0, 50.0) + cylinder([0, 0, 49.99], "Z", shank / 2.0, 30.0) + cone(drum / 2.0, 6.0, 20.0).rotate_x(180.0).translate([0, 0, 0.01]);
let grooves = [];
let widths = [2.5, 4.0, 6.0];
for i in 0..3 { grooves.push(torus(drum / 2.0, widths[i] / 2.0).translate([0, 0, 10.0 + i.to_float() * 14.0])); }
body - grooves[0] - grooves[1] - grooves[2]
