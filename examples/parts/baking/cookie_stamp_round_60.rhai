// Cookie stamp: 60 mm face with a 6-petal flower relief 2 mm deep, 40 mm knob handle 25 mm tall
let d = 60.0; // [40.0, 80.0] Stamp diameter (mm)
let relief = 2.0; // [1.0, 3.0] Relief depth (mm)
let face = cylinder(d / 2.0, 8.0);
let f = face.chamfer(1.0, face.edges("<Z"));
let petals = [];
for k in 0..6 { petals.push(cylinder([d * 0.2, 0, -1], "Z", d * 0.11, relief + 1.0).rotate_z(k.to_float() * 60.0)); }
let center = cylinder([0, 0, -1], "Z", d * 0.08, relief + 1.0);
let ring = cylinder([0, 0, -1], "Z", d / 2.0 - 3.0, relief + 1.0) - cylinder([0, 0, -2], "Z", d / 2.0 - 4.5, relief + 3.0);
let knob = cylinder([0, 0, 7.99], "Z", 8.0, 12.0) + sphere([0, 0, 8.0 + 12.0 + 6.0], 14.0) & cylinder([0, 0, 7.99], "Z", 20.0, 30.0);
f - fuse_all(petals) - center - ring + knob
