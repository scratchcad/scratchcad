// Hose barb 10 mm to 1/4 in BSP: three barbs 11.5 mm on a 9 mm stem, 17 mm hex, 6 mm bore
let barb_d = 11.5; // [5.0, 30.0] Barb diameter (mm)
let stem_d = 9.0; // [4.0, 26.0] Stem diameter (mm)
let barbs = 3; // [2, 5] Barbs
let hex = 17.0; // [10.0, 36.0] Hex size (mm)
let thread_d = 13.16; // [9.7, 26.4] Thread diameter (mm)
let rc = hex / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let parts = [polygon(pts).to_face().extrude(6.0), cylinder([0, 0, -10.0], "Z", thread_d / 2.0, 10.01), cylinder([0, 0, 5.99], "Z", stem_d / 2.0, barbs.to_float() * 6.0 + 2.0)];
for k in 0..barbs { parts.push(cone(barb_d / 2.0, stem_d / 2.0, 5.0).translate([0, 0, 7.0 + k.to_float() * 6.0])); }
fuse_all(parts) - cylinder([0, 0, -11], "Z", 3.0, 50.0)
