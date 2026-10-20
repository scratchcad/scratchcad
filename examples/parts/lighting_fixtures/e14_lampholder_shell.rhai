// E14 lampholder outer shell: 28 mm OD, 35 mm tall, 1.5 mm wall, 10 mm M10 x 1 nipple entry, shade ring thread band
let od = 28.0; // [24.0, 34.0] Shell OD (mm)
let height = 35.0; // [28.0, 45.0] Height (mm)
let wall = 1.5; // [1.0, 2.5] Wall (mm)
let shell = cylinder(od / 2.0, height) - cylinder([0, 0, 3.0], "Z", od / 2.0 - wall, height);
let bands = [];
for k in 0..5 { bands.push(cylinder([0, 0, height - 14.0 + k.to_float() * 2.5], "Z", od / 2.0 + 0.6, 1.0)); }
shell + fuse_all(bands) - cylinder([0, 0, -1], "Z", 5.0, 5.0)
