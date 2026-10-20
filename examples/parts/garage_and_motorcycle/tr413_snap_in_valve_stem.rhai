// TR413 snap-in tubeless tyre valve: 19 mm base flange, 11.5 mm rim hole groove 2 mm, 42.5 mm overall, rubber body tapering to 9 mm, 8V1 cap thread 7.7 mm x 8 mm, 3.5 mm air passage
let length = 42.5; // [30.0, 60.0] Overall length (mm)
let base_d = 19.0; // [16.0, 22.0] Base flange diameter (mm)
let rim_hole = 11.5; // [8.8, 16.0] Rim hole diameter (mm)
let rim_t = 2.0; // [1.5, 4.0] Rim thickness (mm)
let passage = 3.5; // [2.5, 5.0] Air passage diameter (mm)
const thread_len = 8.0;
let rb = base_d / 2.0;
let rh = rim_hole / 2.0;
const zg = 3.0;
let zt = length - thread_len;
let prof = [[0.0, 0.0], [rb - 1.0, 0.0], [rb, 1.0], [rb, 2.0], [rb - 1.0, zg], [rh, zg], [rh, zg + rim_t], [rh + 1.6, zg + rim_t + 1.0], [rh + 1.0, zg + rim_t + 5.0], [4.5, zt - 6.0], [4.5, zt - 3.0], [4.0, zt - 3.0], [3.85, zt]];
const turns = 10;
for i in 0..turns {
    let z = zt + i.to_float() * thread_len / turns.to_float();
    prof.push([3.85, z + 0.2]);
    prof.push([3.4, z + 0.4]);
    prof.push([3.85, z + thread_len / turns.to_float()]);
}
prof.push([3.4, length]);
prof.push([0.0, length]);
let valve = polygon("XZ", prof).to_face().revolve("Z", 360);
valve - cylinder([0, 0, -1.0], "Z", passage / 2.0, length + 2.0)
