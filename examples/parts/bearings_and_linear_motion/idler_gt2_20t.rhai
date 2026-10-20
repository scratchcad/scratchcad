// GT2 20-tooth idler with bearings: 5 mm bore (3 mm optional), 18 mm flanges, 12.2 mm tooth tips, 8.5 mm belt channel
let teeth = 20; // [16, 40] Teeth
let bore = 5.0; // [3.0, 8.0] Bore (mm)
let belt_w = 8.5; // [6.5, 11.0] Belt channel width (mm)
let flange_d = 18.0; // [14.0, 30.0] Flange diameter (mm)
let tip_d = teeth.to_float() * 2.0 / PI() - 0.508;
let body = cylinder(tip_d / 2.0, belt_w + 2.0) + cylinder(flange_d / 2.0, 1.0) + cylinder([0, 0, belt_w + 1.0], "Z", flange_d / 2.0, 1.0);
let grooves = [];
for i in 0..teeth { grooves.push(cylinder([tip_d / 2.0 - 0.2, 0, 1.0], "Z", 0.555, belt_w).rotate_z(i * 360.0 / teeth.to_float())); }
(body - fuse_all(grooves)) - cylinder([0, 0, -1], "Z", bore / 2.0, belt_w + 4.0)
