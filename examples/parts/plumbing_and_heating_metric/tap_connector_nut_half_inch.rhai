// Flexible tap connector nut G1/2 (BSP, 20.955 mm major, 14 TPI): 24 mm hex 11 mm tall, ring-groove female thread, 2 mm base with 13 mm hose-ferrule hole, 30 degree corner chamfers
let hex_af = 24.0; // [22.0, 30.0] Hex across flats (mm)
let height = 11.0; // [8.0, 16.0] Nut height (mm)
let base_t = 2.0; // [1.5, 4.0] Base thickness (mm)
let ferrule = 13.0; // [8.0, 16.0] Ferrule hole diameter (mm)
const major = 20.955;
const pitch = 1.814;
let rmaj = major / 2.0 + 0.1;
let rmin = rmaj - pitch * 0.64;
let rc = hex_af / 3.0.sqrt();
let pts = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
    pts.push([rc * a.cos(), rc * a.sin(), 0]);
}
let hex = polygon(pts).to_face().extrude([0, 0, height]);
let c = (rc - hex_af / 2.0) * 0.9 + 0.3;
let chamfer_body = polygon([[0, 0, 0], [hex_af / 2.0 * 0.97, 0, 0], [rc + 0.5, 0, c + 0.5], [rc + 0.5, 0, height - c - 0.5], [hex_af / 2.0 * 0.97, 0, height], [0, 0, height]]).to_face().revolve("Z", 360);
let nut = hex & chamfer_body;
let tp = [[0, 0, base_t], [rmin, 0, base_t]];
let z = base_t;
while z < height + pitch {
    tp.push([rmaj, 0, z + pitch * 0.5]);
    tp.push([rmin, 0, z + pitch]);
    z += pitch;
}
tp.push([0, 0, z]);
let thread_cut = polygon(tp).to_face().revolve("Z", 360);
nut - thread_cut - cylinder([0, 0, -1], "Z", min(ferrule, rmin * 2.0 - 1.0) / 2.0, base_t + 2.0)
