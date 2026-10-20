// Skirted pot knob for 6 mm 18-tooth knurled (splined) shafts, as on Alpha 16 mm pots: 20 mm cap 14 mm tall, 26 mm skirt 2.5 mm with 0-10 tick ring, 18-tooth bore 6.1/5.5 mm 10 mm deep, 24 flutes, pointer line
let cap_d = 20.0; // [12.0, 30.0] Cap diameter (mm)
let height = 14.0; // [10.0, 22.0] Knob height (mm)
let skirt_d = 26.0; // [16.0, 40.0] Skirt diameter (mm)
let bore_depth = 10.0; // [6.0, 14.0] Bore depth (mm)
let flutes = 24; // [0, 40] Number of grip flutes
let ticks = 11; // [0, 21] Number of scale ticks
const teeth = 18;
let r = cap_d / 2.0;
let rs = max(skirt_d / 2.0, r + 1.5);
let cap = cylinder([0, 0, 2.0], "Z", r, height - 2.0);
let cap = cap.chamfer(1.0, cap.edges(">Z"));
let skirt = polygon([[0, 0, 0], [rs, 0, 0], [rs, 0, 1.0], [r, 0, 2.5], [0, 0, 2.5]]).to_face().revolve("Z", 360);
let body = cap + skirt;
let cuts = [];
for k in 0..flutes {
    cuts.push(cylinder([r + 0.25, 0, 4.0], "Z", 0.7, height).rotate_z(k.to_float() * 360.0 / flutes.to_float()));
}
for k in 0..ticks {
    let a = -135.0 + k.to_float() * 270.0 / max(ticks - 1, 1).to_float();
    cuts.push(box_from_corners([r + 0.8, -0.3, 0.6], [rs + 1.0, 0.3, 3.0]).rotate_z(a + 90.0));
}
let pts = [];
for i in 0..(teeth * 2) {
    let a = i.to_float() * PI() / teeth.to_float();
    let rr = if i % 2 == 0 { 3.05 } else { 2.75 };
    pts.push([rr * a.cos(), rr * a.sin(), -1.0]);
}
let bore = polygon(pts).to_face().extrude([0, 0, bore_depth + 1.0]);
let pointer = box_from_corners([0.5, -0.5, height - 0.6], [r + 1.0, 0.5, height + 1.0]).rotate_z(90.0);
body - fuse_all(cuts + [pointer]) - bore
