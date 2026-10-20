// ARRI-style rosette mount: 31.8 mm disc 8 mm thick with 60 radial V teeth 0.8 mm deep at the rim on its face (from 5 mm radius out), M6 tapped centre hole (5 mm core) and a 22 mm boss 6 mm long behind it for a handle
let teeth = 60; // [24, 72] Number of rosette teeth
let disc_d = 31.8; // [25.0, 40.0] Rosette diameter (mm)
let boss_len = 6.0; // [2.0, 20.0] Boss length (mm)
const t = 8.0;
const tooth_h = 0.8;
let r = disc_d / 2.0;
let disc = cylinder([0, 0, 0], "Z", r, t);
let boss = cylinder([0, 0, -boss_len - 0.5], "Z", 11.0, boss_len + 0.5);
let step = 360.0 / teeth.to_float();
const rin = 5.0;
let rout = r + 1.0;
let grooves = [];
for i in 0..teeth {
    let a0 = (i.to_float() * step - 0.45 * step) * PI() / 180.0;
    let a1 = (i.to_float() * step + 0.45 * step) * PI() / 180.0;
    let am = (i.to_float() * step) * PI() / 180.0;
    let k_in = rin / r;
    let k_out = rout / r;
    let tri_in = polygon([[rin * cos(a0), rin * sin(a0), t + 0.01], [rin * cos(am), rin * sin(am), t - tooth_h * k_in], [rin * cos(a1), rin * sin(a1), t + 0.01]]);
    let tri_out = polygon([[rout * cos(a0), rout * sin(a0), t + 0.01], [rout * cos(am), rout * sin(am), t - tooth_h * k_out], [rout * cos(a1), rout * sin(a1), t + 0.01]]);
    grooves.push(loft([tri_in, tri_out], true));
}
let tap = cylinder([0, 0, -boss_len - 1.0], "Z", 2.5, t + boss_len + 2.0);
disc + boss - compound(grooves) - tap
