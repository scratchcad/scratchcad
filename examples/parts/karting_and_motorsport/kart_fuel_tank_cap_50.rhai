// Kart fuel tank cap for a 50 mm filler neck: 60 mm knurled cap 22 mm tall with 24 grip flutes (2 mm radius), 4 mm top, 50.5 mm bore over the neck (thread shown as a plain bore) with a 44 mm seal recess, and a 6 mm vent spigot 10 mm tall with a 3 mm hole, offset 15 mm
let neck_d = 50.0; // [38.0, 56.0] Filler neck diameter (mm)
let cap_h = 22.0; // [16.0, 30.0] Cap height (mm)
let flutes = 24; // [12, 36] Number of grip flutes
const top_t = 4.0;
let ro = neck_d / 2.0 + 5.0;
let cap = cylinder([0, 0, 0], "Z", ro, cap_h);
let cap = cap.chamfer(1.0, cap.edges(">Z"));
let spigot = cylinder([15.0, 0, cap_h - 1.0], "Z", 3.0, 11.0);
let body = cap + spigot;
let cuts = [cylinder([0, 0, -1.0], "Z", neck_d / 2.0 + 0.25, cap_h - top_t + 1.0)];
for i in 0..flutes {
    let a = i.to_float() * 360.0 / flutes.to_float();
    cuts.push(cylinder([ro + 0.6, 0, -1.0], "Z", 2.0, cap_h - 3.0).rotate_z(a));
}
cuts.push(cylinder([15.0, 0, cap_h - top_t - 2.0], "Z", 1.5, top_t + 14.0));
body - fuse_all(cuts)
