// Fraction circle piece, 1/6: 100 mm circle sector of 60 degrees, 5 mm thick, embossed 1/6 bar 1 mm
let diameter = 100.0; // [60.0, 150.0] Circle diameter (mm)
let parts = 6; // [2, 12] Fraction denominator
let t = 5.0; // [3.0, 8.0] Thickness (mm)
let a = 2.0 * PI() / parts.to_float();
let pts = [[0.0, 0.0]];
for i in 0..=12 { let b = a * i.to_float() / 12.0; pts.push([diameter / 2.0 * b.cos(), diameter / 2.0 * b.sin()]); }
let piece = polygon(pts).to_face().extrude([0, 0, t]);
let mid = a / 2.0;
let bar = box_centered(12.0, 1.5, 2.0).translate([diameter * 0.3, 0, t]).rotate_z(mid * 180.0 / PI());
piece + bar
