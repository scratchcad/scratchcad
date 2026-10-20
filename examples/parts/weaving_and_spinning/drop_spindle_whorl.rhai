// Top-whorl drop spindle whorl: 60 mm disc 10 mm thick tapering to 6 mm at the rim, 8 mm shaft bore, 4 weight pockets
let d = 60.0; // [40.0, 90.0] Whorl diameter (mm)
let t = 10.0; // [6.0, 15.0] Hub thickness (mm)
let bore = 8.0; // [6.0, 10.0] Shaft bore (mm)
let p = sketch("XZ").move_to(bore / 2.0, 0).hline_to(d / 2.0).vline_to(t * 0.6).line_to(d * 0.2, t).hline_to(bore / 2.0).close();
let w = p.face().revolve("Z", 360);
let pockets = [];
for k in 0..4 { let a = (k.to_float() * 90.0 + 45.0) * PI() / 180.0; pockets.push(cylinder([d * 0.33 * a.cos(), d * 0.33 * a.sin(), -1], "Z", 4.0, 4.0)); }
w - compound(pockets)
