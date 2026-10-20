// Lamp shade spider fitter: 3 spokes to a 150 mm ring, 29 mm washer for the lampholder, 3 mm wire-style 4 mm rod
let ring = 150.0; // [100.0, 300.0] Ring diameter (mm)
let washer = 29.0; // [11.0, 42.0] Center hole (mm)
let rod = 4.0; // [3.0, 6.0] Rod diameter (mm)
let drop = 30.0; // [0.0, 80.0] Center drop (mm)
let r = rod / 2.0;
let w = cylinder([0, 0, -drop], "Z", washer / 2.0 + 6.0, 1.5) - cylinder([0, 0, -drop - 1.0], "Z", washer / 2.0, 4.0);
let rr = cylinder(ring / 2.0 + r, rod) - cylinder([0, 0, -1], "Z", ring / 2.0 - r, rod + 2.0);
let spokes = [];
let span = ring / 2.0 - washer / 2.0 - 4.0;
let len = (span * span + drop * drop).sqrt();
let ang = (drop / span).atan() * 180.0 / PI();
for k in 0..3 { spokes.push(cylinder([washer / 2.0 + 4.0, 0, -drop + 0.75], "X", r, len).rotate([washer / 2.0 + 4.0, 0, -drop + 0.75], "Y", -ang).rotate_z(k.to_float() * 120.0)); }
w + rr + fuse_all(spokes)
