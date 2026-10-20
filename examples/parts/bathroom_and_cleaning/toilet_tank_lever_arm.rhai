// Toilet tank trip lever arm: 200 mm flat arm 8 x 3 mm, 7 chain holes 3 mm at 12 mm pitch, hub with 1/4 in (6.4 mm) square drive
let length = 200.0; // [150.0, 260.0] Arm length (mm)
let width = 8.0; // [6.0, 12.0] Arm width (mm)
let t = 3.0; // [2.0, 5.0] Arm thickness (mm)
let holes = 7; // [3, 12] Chain holes
let pitch = 12.0; // [8.0, 20.0] Chain hole pitch (mm)
const square = 6.4;
let arm = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, t]) + cylinder([length, 0, 0], "Z", width / 2.0, t);
let hub = cylinder(9.0, 10.0) - box_centered(square, square, 30.0);
let cuts = [];
for i in 0..holes { cuts.push(cylinder([length - i.to_float() * pitch, 0, -1], "Z", 1.5, t + 2.0)); }
arm + hub - compound(cuts)
