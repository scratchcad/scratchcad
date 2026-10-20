// HTD 5M timing pulley, 20 teeth, 15 mm belt: 31.83 mm pitch dia, 30.69 mm OD, flanges 36 mm, 8 mm bore
let teeth = 20; // [12, 60] Teeth
let belt_w = 16.0; // [10.0, 30.0] Toothed width (mm)
let flange_d = 36.0; // [25.0, 120.0] Flange diameter (mm)
let bore = 8.0; // [5.0, 20.0] Bore (mm)
let hub_d = 22.0; // [15.0, 40.0] Hub diameter (mm)
let hub_l = 8.0; // [0.0, 20.0] Hub length (mm)
let pd = teeth.to_float() * 5.0 / PI();
let od = pd - 1.144;
let body = cylinder([0, 0, 1.5], "Z", od / 2.0, belt_w);
let grooves = [];
for i in 0..teeth { grooves.push(cylinder([od / 2.0 - 0.3, 0, 0], "Z", 1.6, belt_w + 4.0).rotate_z(i * 360.0 / teeth.to_float())); }
body = body - fuse_all(grooves);
let flanges = cylinder(flange_d / 2.0, 1.5) + cylinder([0, 0, belt_w + 1.5], "Z", flange_d / 2.0, 1.5);
let hub = cylinder([0, 0, belt_w + 2.99], "Z", hub_d / 2.0, hub_l + 0.01);
let p = fuse_all([body, flanges, hub]) - cylinder([0, 0, -1], "Z", bore / 2.0, belt_w + hub_l + 6.0);
p - cylinder([0, 0, belt_w + 3.0 + hub_l / 2.0], "X", 2.0, hub_d)
