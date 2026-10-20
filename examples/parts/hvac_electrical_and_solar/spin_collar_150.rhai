// Spin-in start collar for 6 in (150 mm) flex duct: 0.6 mm galvanized cylinder 100 mm long, 25 mm flange with 6 screw holes, retaining bead 20 mm from the end
let duct_d = 150.0; // [100.0, 300.0] Collar diameter (mm)
let length = 100.0; // [60.0, 150.0] Collar length (mm)
let flange = 25.0; // [15.0, 40.0] Flange width (mm)
let holes = 6; // [4, 12] Number of flange screw holes
const t = 0.8;
let r = duct_d / 2.0;
let zb = length - 20.0;
let prof = polygon([[r - t, 0, t], [r - t, 0, zb - 3.0], [r - t + 1.5, 0, zb], [r - t, 0, zb + 3.0], [r - t, 0, length],
    [r, 0, length], [r, 0, zb + 3.0], [r + 1.5, 0, zb], [r, 0, zb - 3.0], [r, 0, t], [r + flange, 0, t], [r + flange, 0, 0], [r - t, 0, 0]]);
let c = prof.to_face().revolve("Z", 360);
let h = [];
for i in 0..holes {
    let a = i.to_float() * 360.0 / holes.to_float();
    h.push(cylinder([r + flange * 0.55, 0, -1], "Z", 2.2, 3.0).rotate_z(a));
}
c - fuse_all(h)
