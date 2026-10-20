// Rosette side handle for a cine camera: 120 mm long grip, 34 mm max diameter with straight-taper ends down to 28 mm, 31.8 mm rosette head 10 mm long carrying 36 radial V teeth 0.8 mm deep (from 6 mm radius out), 6.5 mm through bore for an M6 bolt and a 12 mm counterbore 20 mm deep for its head at the bottom
let length = 120.0; // [90.0, 160.0] Grip length (mm)
let grip_d = 34.0; // [28.0, 40.0] Grip diameter (mm)
let teeth = 36; // [24, 60] Number of rosette teeth
const head_d = 31.8;
const head_len = 10.0;
const tooth_h = 0.8;
let rg = grip_d / 2.0;
let re = rg - 3.0;
let rh = head_d / 2.0;
let total = length + head_len;
let profile = polygon([
    [0, 0, 0], [re - 1.0, 0, 0], [re, 0, 1.0], [rg, 0, 25.0], [rg, 0, length - 25.0], [re, 0, length],
    [rh, 0, length], [rh, 0, total], [0, 0, total]]);
let handle = face(profile).revolve("Z", 360.0);
let step = 360.0 / teeth.to_float();
const rin = 6.0;
let rout = rh + 1.0;
let grooves = [];
for i in 0..teeth {
    let a0 = (i.to_float() * step - 0.45 * step) * PI() / 180.0;
    let a1 = (i.to_float() * step + 0.45 * step) * PI() / 180.0;
    let am = (i.to_float() * step) * PI() / 180.0;
    let tri_in = polygon([[rin * cos(a0), rin * sin(a0), total + 0.01], [rin * cos(am), rin * sin(am), total - tooth_h * rin / rh], [rin * cos(a1), rin * sin(a1), total + 0.01]]);
    let tri_out = polygon([[rout * cos(a0), rout * sin(a0), total + 0.01], [rout * cos(am), rout * sin(am), total - tooth_h * rout / rh], [rout * cos(a1), rout * sin(a1), total + 0.01]]);
    grooves.push(loft([tri_in, tri_out], true));
}
let bore = cylinder([0, 0, -1.0], "Z", 3.25, total + 2.0);
let cbore = cylinder([0, 0, -1.0], "Z", 6.0, 21.0);
handle - compound(grooves) - bore - cbore
