// PTO shaft yoke quick-release collar for a 1-3/8 inch 6-spline yoke: sleeve 58 mm outside and 26 mm long, 44.5 mm bore over the yoke hub with a 2.5 mm deep, 8 mm long internal recess at the back for the locking balls and spring, a 2 mm lip at the front, and three 2 mm deep V grip grooves around the outside
let bore = 44.5; // [36.0, 56.0] Bore (mm)
let outer_d = 58.0; // [48.0, 72.0] Outside diameter (mm)
let length = 26.0; // [20.0, 36.0] Collar length (mm)
let recess_depth = 2.5; // [1.5, 3.5] Ball recess depth (mm)
let grooves = 3; // [1, 4] Number of grip grooves
const recess_len = 8.0;
const lip = 2.0;
const gd = 2.0;
let rb = bore / 2.0;
let ro = max(outer_d / 2.0, rb + recess_depth + gd + 2.0);
let pts = [[rb - lip, 0, 0], [ro - 1.0, 0, 0], [ro, 0, 1.0]];
let pitch = (length - 8.0) / grooves;
let gh = min(1.5, pitch * 0.35);
for i in 0..grooves {
    let z = 4.0 + (i + 0.5) * pitch;
    pts.push([ro, 0, z - gh]);
    pts.push([ro - gd, 0, z]);
    pts.push([ro, 0, z + gh]);
}
for p in [[ro, length - 1.0], [ro - 1.0, length], [rb + recess_depth, length], [rb + recess_depth, length - recess_len], [rb, length - recess_len - 1.0], [rb, 2.5], [rb - lip, 2.5]] {
    pts.push([p[0], 0, p[1]]);
}
polygon(pts).to_face().revolve("Z", 360.0)
