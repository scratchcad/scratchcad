// Corner cabinet carousel bearing ring: 80 mm thrust ring 6 mm thick with 12 ball pockets 6.5 mm for 6 mm balls on a 64 mm PCD and a 20 mm pole bore
let pcd = 64.0; // [40.0, 120.0] Ball circle diameter (mm)
let balls = 12; // [6, 20] Number of ball pockets
let pole = 20.0; // [12.0, 30.0] Pole bore (mm)
const t = 6.0;
let od = pcd + 16.0;
let r = cylinder([0, 0, 0], "Z", od / 2.0, t) - cylinder([0, 0, -1.0], "Z", pole / 2.0, t + 2.0);
let pockets = [];
for i in 0..balls { let a = i.to_float() * 2.0 * PI() / balls.to_float(); pockets.push(cylinder([pcd / 2.0 * cos(a), pcd / 2.0 * sin(a), t - 4.0], "Z", 3.25, 5.0)); }
r - fuse_all(pockets)
