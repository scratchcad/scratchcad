// Cosplay helmet visor pivot: 30 mm rosette 5 mm thick with 12 detent bumps, a 5 mm M5 pivot hole and a 12 x 25 mm visor arm tab 3 mm thick
let dia = 30.0; // [22.0, 40.0] Rosette diameter (mm)
let arm = 25.0; // [15.0, 40.0] Arm length (mm)
const t = 5.0;
let r = cylinder([0, 0, 0], "Z", dia / 2.0, t);
let bumps = [];
for i in 0..12 { bumps.push(sphere([dia / 2.0 - 4.0, 0, t], 1.2).rotate_z(i.to_float() * 30.0)); }
let tab = box_from_corners([dia / 2.0 - 3.0, -6.0, 0], [dia / 2.0 + arm, 6.0, 3.0]);
r + fuse_all(bumps) + tab - cylinder([0, 0, -1.0], "Z", 2.6, t + 4.0)
