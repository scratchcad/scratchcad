// Travel cable lock dial ring: 14 mm dial 5 mm thick with 10 grip flutes, a 7 mm bore with one 1.5 mm key notch for the lock shaft
let dia = 14.0; // [10.0, 20.0] Dial diameter (mm)
let bore = 7.0; // [5.0, 9.0] Bore diameter (mm)
const t = 5.0;
let d = cylinder([0, 0, 0], "Z", dia / 2.0, t);
let flutes = [];
for i in 0..10 { flutes.push(cylinder([dia / 2.0 + 0.4, 0, -1.0], "Z", 0.8, t + 2.0).rotate_z(i.to_float() * 36.0)); }
d - fuse_all(flutes) - cylinder([0, 0, -1.0], "Z", bore / 2.0, t + 2.0) - box_from_corners([bore / 2.0 - 0.5, -0.75, -1.0], [bore / 2.0 + 1.0, 0.75, t + 1.0])
