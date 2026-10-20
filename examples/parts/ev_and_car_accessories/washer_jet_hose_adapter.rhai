// Windscreen washer jet hose adapter: reducer from a 4 mm ID washer hose to a 5 mm jet inlet hose, 3 barbs each end (4.6 / 5.8 mm over the barbs), 7.5 mm collar, 2 mm bore
let small_hose = 4.0; // [3.0, 4.5] Small hose inside diameter (mm)
let large_hose = 5.0; // [4.5, 6.0] Large hose inside diameter (mm)
let barbs = 3; // [2, 5] Number of barbs per end
let barb_len = 3.0; // [2.5, 4.0] Barb length (mm)
let bore = 2.0; // [1.5, 2.5] Bore (mm)

const collar_h = 2.5;
// small barbed end, z from 0 upward; the bore keeps a 0.5 mm wall under the barbs
let rs_min = small_hose / 2.0 - 0.2;
let ri = min(bore / 2.0, rs_min - 0.7);
let pts = [[ri, 0, 0]];
let rs_max = small_hose / 2.0 + 0.3;
for i in 0..barbs {
    let z = i * barb_len;
    pts.push([rs_min - 0.2, 0, z]);
    pts.push([rs_max, 0, z + barb_len]);
}
let z1 = barbs * barb_len;
let r_collar = large_hose / 2.0 + 1.25;
pts.push([r_collar, 0, z1]);
pts.push([r_collar, 0, z1 + collar_h]);
let rl_min = large_hose / 2.0 - 0.2;
let rl_max = large_hose / 2.0 + 0.4;
let z2 = z1 + collar_h;
for i in 0..barbs {
    let z = z2 + i * barb_len;
    pts.push([rl_max, 0, z]);
    pts.push([rl_min, 0, z + barb_len]);
}
let top = z2 + barbs * barb_len;
pts.push([ri, 0, top]);
polygon(pts).to_face().revolve("Z", 360.0)
