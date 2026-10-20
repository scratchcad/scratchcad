// Gate drop bolt ground keeper: 60 mm round flange 5 mm with three 6.5 mm screw holes, over a 25 mm socket tube 50 mm deep for a 16 mm drop bolt, with a 5 mm drain hole
let bolt = 16.0; // [10.0, 22.0] Drop bolt diameter (mm)
let depth = 50.0; // [30.0, 80.0] Socket depth (mm)
const t = 5.0;
let f = cylinder([0, 0, 0], "Z", 30.0, t);
let tube = cylinder([0, 0, -depth], "Z", bolt / 2.0 + 4.0, depth + 0.01);
let holes = [cylinder([0, 0, -depth + 3.0], "Z", bolt / 2.0 + 1.0, depth + t), cylinder([0, 0, -depth - 1.0], "Z", 2.5, 5.0)];
for i in 0..3 { let a = (90.0 + 120.0 * i.to_float()) * PI() / 180.0; holes.push(cylinder([22.0 * cos(a), 22.0 * sin(a), -1.0], "Z", 3.25, t + 2.0)); }
f + tube - fuse_all(holes)
