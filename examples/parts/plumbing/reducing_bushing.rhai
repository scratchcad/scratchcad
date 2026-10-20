// Hex reducing bushing 1 in male to 1/2 in female (NPT): 33.4 mm male, 26 mm hex 6 mm, 21.3 mm female bore 14 mm deep
let male_d = 33.4; // [21.3, 60.3] Male thread diameter (mm)
let male_l = 17.0; // [10.0, 30.0] Male thread length (mm)
let hex = 36.0; // [24.0, 70.0] Hex size (mm)
let female_d = 21.3; // [13.0, 48.0] Female diameter (mm)
let rc = hex / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let part = polygon(pts).to_face().extrude(6.0).translate([0, 0, male_l - 0.01]) + cone(male_d / 2.0 - 0.6, male_d / 2.0, male_l);
part - cylinder([0, 0, male_l + 6.0 - 14.0], "Z", female_d / 2.0, 15.0) - cylinder([0, 0, -1], "Z", female_d / 2.0 - 2.5, male_l + 10.0)
