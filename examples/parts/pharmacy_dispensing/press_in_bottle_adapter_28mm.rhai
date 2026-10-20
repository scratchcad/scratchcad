// Press-in bottle adapter (PIBA) for 28 mm neck medicine bottles: 21 mm plug 12 mm long with 3 sealing ribs 0.5 mm proud and a lead-in chamfer, hollow from below around a 7.6 mm centre stem, 27 mm flange 2 mm thick, and an oral syringe tip socket 4.4 mm across and 8 mm deep feeding a 2 mm duct
let plug_d = 21.0; // [16.0, 26.0] Plug diameter (mm)
let plug_len = 12.0; // [10.0, 18.0] Plug length (mm)
let flange_d = 27.0; // [22.0, 34.0] Flange diameter (mm)
let socket_d = 4.4; // [3.5, 5.5] Syringe socket diameter (mm)
const flange_t = 2.0;
const socket_depth = 8.0;
const r_d = 1.0;
const r_st = 3.8;
const rib = 0.5;
let r_p = plug_d / 2.0;
let r_f = max(flange_d / 2.0, r_p + 1.5);
let r_s = socket_d / 2.0;
let z_t = plug_len + flange_t;
let step = (plug_len - 3.0) / 3.0;
let pts = [
    [r_d, 0, 0], [r_st, 0, 0], [r_st, 0, plug_len - 1.5], [r_p - 1.5, 0, plug_len - 1.5],
    [r_p - 1.5, 0, 0], [r_p - 0.5, 0, 0], [r_p, 0, 0.8],
];
for k in 0..3 {
    let z = 2.0 + k * step;
    pts.push([r_p, 0, z]);
    pts.push([r_p + rib, 0, z + 0.6]);
    pts.push([r_p, 0, z + 1.2]);
}
for p in [[r_p, plug_len], [r_f, plug_len], [r_f, z_t], [r_s, z_t], [r_s, z_t - socket_depth], [r_d, z_t - socket_depth]] {
    pts.push([p[0], 0, p[1]]);
}
polygon(pts).to_face().revolve("Z", 360.0)
