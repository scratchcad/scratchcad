// Wheelbarrow handle grip: 140 mm grip for a 32 mm handle tube, 40 mm OD with 6 finger ridges 1.5 mm and a 45 mm closed end flange
let length = 140.0; // [100.0, 180.0] Grip length (mm)
let tube = 32.0; // [25.0, 40.0] Handle tube OD (mm)
let r = tube / 2.0 + 4.0;
let g = cylinder([0, 0, 0], "Z", r, length) + cylinder([0, 0, length - 0.01], "Z", r + 2.5, 6.0);
let ridges = [];
for i in 0..6 { ridges.push(cylinder([0, 0, 15.0 + i.to_float() * (length - 35.0) / 5.0], "Z", r + 1.5, 4.0)); }
g + fuse_all(ridges) - cylinder([0, 0, -1.0], "Z", tube / 2.0 + 0.2, length - 3.0)
