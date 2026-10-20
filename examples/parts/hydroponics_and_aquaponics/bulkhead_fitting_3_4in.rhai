// Tank bulkhead fitting body, 3/4 inch BSP: 45 mm flange 5 mm thick with a gasket groove (15 to 19 mm radius, 1 mm deep) on its face, a 26.4 mm threaded shank 30 mm long with 14 TPI ring ridges (1.814 mm pitch, 0.55 mm deep) and a 19 mm through bore
let thread_od = 26.4; // [20.9, 33.2] Thread outside diameter (mm)
let shank_len = 30.0; // [20.0, 50.0] Shank length (mm)
let flange_d = 45.0; // [38.0, 70.0] Flange diameter (mm)
let bore_d = 19.0; // [12.0, 26.0] Bore diameter (mm)
const flange_t = 5.0;
const pitch = 1.814;
const depth = 0.55;
let tr = thread_od / 2.0;
let br = min(bore_d / 2.0, tr - 2.5);
let fr = max(flange_d / 2.0, tr + 8.0);
let g0 = tr + 1.5;
let g1 = tr + 5.0;
let pts = [[br, 0, 0], [fr, 0, 0], [fr, 0, flange_t], [g1, 0, flange_t], [g1, 0, flange_t - 1.0], [g0, 0, flange_t - 1.0], [g0, 0, flange_t], [tr, 0, flange_t]];
let z = flange_t + 2.0;
pts.push([tr, 0, z]);
let n = ((shank_len - 4.0) / pitch).floor().to_int();
for i in 0..n {
    pts.push([tr - depth, 0, z + pitch * (i.to_float() + 0.5)]);
    pts.push([tr, 0, z + pitch * (i.to_float() + 1.0)]);
}
pts.push([tr, 0, flange_t + shank_len - 0.6]);
pts.push([tr - 0.6, 0, flange_t + shank_len]);
pts.push([br, 0, flange_t + shank_len]);
face(polygon(pts)).revolve("Z", 360.0)
