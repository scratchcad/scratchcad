// GT2 timing pulley, 20 teeth, 2 mm pitch: 12.73 mm pitch diameter (12.22 mm OD), 7 mm wide toothed section for 6 mm belt, 16 mm flanges, 16 mm hub 7 mm long with M3 set screw, 5 mm bore
let teeth = 20; // [12, 60] Number of teeth
let belt_width = 6.0; // [4.0, 15.0] Belt width (mm)
let bore = 5.0; // [2.0, 12.0] Bore diameter (mm)
let hub_length = 7.0; // [4.0, 15.0] Hub length (mm)
const pitch = 2.0;
const pld = 0.254;
const groove_r = 0.555;
const groove_depth = 0.75;
let rp = teeth.to_float() * pitch / PI() / 2.0;
let ro = rp - pld;
let tooth_len = belt_width + 1.0;
let hub_r = max(ro + 1.5, bore / 2.0 + 4.0);
let flange_r = ro + 1.6;
let z0 = hub_length;
let toothed = cylinder([0, 0, z0], "Z", ro, tooth_len);
let grooves = [];
for i in 0..teeth {
    let a = i.to_float() * 360.0 / teeth.to_float();
    grooves.push(cylinder([ro - groove_depth + groove_r, 0, z0 - 1.0], "Z", groove_r, tooth_len + 2.0).rotate("Z", a));
}
toothed = toothed - compound(grooves);
let hub = cylinder(hub_r, hub_length + 0.01);
let f1 = cylinder([0, 0, z0 - 1.0], "Z", flange_r, 1.01);
let f2 = cylinder([0, 0, z0 + tooth_len - 0.01], "Z", flange_r, 1.0);
let part = fuse_all([hub, toothed, f1, f2]);
part = part - cylinder([0, 0, -1], "Z", bore / 2.0, z0 + tooth_len + 3.0);
part - cylinder([0, 0, hub_length / 2.0], "X", 1.25, hub_r + 1.0)
