// Music stand tilt knob: 32 mm 6-lobe knob 15 mm thick with an M6 nut pocket (10 mm AF, 5 mm deep) and a 6.4 mm bolt clearance bore
let span = 32.0; // [24.0, 45.0] Knob span (mm)
let t = 15.0; // [10.0, 20.0] Knob thickness (mm)
let lobe = span * 0.16;
let parts = [cylinder([0, 0, 0], "Z", span / 2.0 - lobe, t)];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; parts.push(cylinder([(span / 2.0 - lobe) * cos(a), (span / 2.0 - lobe) * sin(a), 0], "Z", lobe, t)); }
let k = fuse_all(parts);
let hr = 10.0 / 2.0 / cos(PI() / 6.0) + 0.15;
let hp = [];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; hp.push([hr * cos(a), hr * sin(a), 0]); }
k - face(polygon(hp)).extrude([0, 0, 6.0]).translate([0, 0, -1.0]) - cylinder([0, 0, -1.0], "Z", 3.2, t + 2.0)
