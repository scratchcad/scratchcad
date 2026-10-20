// Bed levelling knob for M3: 18 mm knurled knob 8 mm tall with an embedded M3 nut pocket (5.5 mm AF)
let diameter = 18.0; // [12.0, 30.0] Diameter (mm)
let height = 8.0; // [5.0, 15.0] Height (mm)
let ridges = 18; // [8, 36] Ridges
let nut_af = 5.5; // [4.0, 8.0] Nut size (mm)
let knob = cylinder(diameter / 2.0, height).fillet(1.0, ">Z");
let cuts = [];
for i in 0..ridges { cuts.push(cylinder([diameter / 2.0 + 0.4, 0, -1], "Z", 1.0, height + 2.0).rotate_z(i.to_float() * 360.0 / ridges.to_float())); }
let rc = nut_af / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
knob - fuse_all(cuts) - polygon(pts).to_face().extrude(2.6).translate([0, 0, -0.01]) - cylinder([0, 0, -1], "Z", 1.65, height + 2.0)
