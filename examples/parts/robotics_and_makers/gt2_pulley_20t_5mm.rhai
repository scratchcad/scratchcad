// GT2 timing pulley, 20 teeth for 6 mm belt: 12.22 mm tooth OD (12.73 mm pitch diameter), 7 mm toothed width, 16 mm flanges, 16 mm hub 7 mm long, 5 mm bore, two M3 set screws
let teeth = 20; // [12, 60] Number of teeth
let belt_w = 7.0; // [6.5, 11.0] Toothed width (mm)
let bore = 5.0; // [3.0, 8.0] Bore diameter (mm)
let hub_len = 7.0; // [4.0, 10.0] Hub length (mm)
const pitch = 2.0;
const pld = 0.254;
let pd = teeth.to_float() * pitch / PI();
let od = pd - 2.0 * pld;
let ro = od / 2.0;
let flange_r = ro + 2.0;
let hub_r = max(ro, bore / 2.0 + 4.0);
let toothed = cylinder([0, 0, hub_len + 1.0], "Z", ro, belt_w);
let grooves = [];
for i in 0..teeth {
    let a = i.to_float() * 360.0 / teeth.to_float();
    grooves.push(cylinder([ro - 0.2, 0, hub_len], "Z", 0.555, belt_w + 2.0).rotate_z(a));
    grooves.push(box_centered(0.9, 1.11, belt_w + 2.0).translate([ro + 0.25, 0, hub_len + 1.0 + belt_w / 2.0]).rotate_z(a));
}
toothed -= fuse_all(grooves);
let f1 = cylinder([0, 0, hub_len], "Z", flange_r, 1.0);
let f2 = cylinder([0, 0, hub_len + 1.0 + belt_w], "Z", flange_r, 1.0);
let hub = cylinder(hub_r, hub_len + 0.01);
let p = fuse_all([hub, f1, toothed, f2]);
p -= cylinder([0, 0, -1], "Z", bore / 2.0, hub_len + belt_w + 4.0);
for a in [0.0, 90.0] { p -= cylinder([0, 0, hub_len / 2.0], "X", 1.4, hub_r + 1.0).rotate_z(a); }
p
