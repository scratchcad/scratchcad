// 15 mm polybutylene pipe insert (stiffener for PB/PEX 15 x 1.7 mm): 11.5 mm sleeve OD, 1 mm wall, 23 mm long, 14.6 mm stop flange 1 mm thick, 5 barbs 0.25 mm
let sleeve_od = 11.5; // [8.0, 20.0] Sleeve outside diameter (mm)
let wall = 1.0; // [0.6, 2.0] Sleeve wall (mm)
let length = 23.0; // [12.0, 35.0] Sleeve length (mm)
let flange_d = 14.6; // [10.0, 24.0] Flange diameter (mm)
let flange_t = 1.0; // [0.6, 2.0] Flange thickness (mm)
let barbs = 5; // [0, 8] Number of barbs
let ro = sleeve_od / 2.0;
let ri = ro - wall;
let rf = max(flange_d / 2.0, ro + 0.5);
let pts = [[ri, 0, 0], [rf, 0, 0], [rf, 0, flange_t], [ro, 0, flange_t]];
const step = 1.6;
let z0 = flange_t + 2.0;
for k in 0..barbs {
    let z = z0 + k.to_float() * step;
    if z + step < length - 1.5 {
        pts.push([ro, 0, z]);
        pts.push([ro + 0.25, 0, z + step * 0.8]);
        pts.push([ro, 0, z + step * 0.8]);
    }
}
pts.push([ro, 0, length - 0.6]);
pts.push([ro - 0.4, 0, length]);
pts.push([ri, 0, length]);
polygon(pts).to_face().revolve("Z", 360)
