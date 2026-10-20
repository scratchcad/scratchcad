// Reservoir drain tap cap for 3/4 inch garden hose thread (GHT, 26.4 mm major, 11.5 TPI): 33 mm cap 16 mm tall with 18 grip flutes, a 26.6 mm female bore 13 mm deep with internal ring ridges at 2.21 mm pitch, and a 0.8 mm top chamfer
let cap_d = 33.0; // [30.0, 45.0] Cap diameter (mm)
let cap_h = 16.0; // [12.0, 25.0] Cap height (mm)
let flutes = 18; // [8, 30] Number of grip flutes
const bore_r = 13.3;
const pitch = 2.21;
const top = 3.0;
let r = max(cap_d / 2.0, bore_r + 3.0);
let body = cylinder([0, 0, 0], "Z", r, cap_h);
let body = body.chamfer(0.8, body.edges(">Z"));
let depth = cap_h - top;
let pts = [[0, 0, -1.0], [bore_r, 0, -1.0]];
let n = ((depth - 2.0) / pitch).floor().to_int();
for i in 0..n {
    pts.push([bore_r - 1.0, 0, pitch * (i.to_float() + 0.5)]);
    pts.push([bore_r, 0, pitch * (i.to_float() + 1.0)]);
}
pts.push([bore_r, 0, depth - 1.0]);
pts.push([bore_r - 1.0, 0, depth]);
pts.push([0, 0, depth]);
let bore = face(polygon(pts)).revolve("Z", 360.0);
let cuts = [bore];
for i in 0..flutes {
    cuts.push(cylinder([r + 0.6, 0, 2.0], "Z", 1.4, cap_h).rotate_z(i.to_float() * 360.0 / flutes.to_float()));
}
body - fuse_all(cuts)
