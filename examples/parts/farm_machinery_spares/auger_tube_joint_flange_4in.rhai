// Grain auger tube joint flange for 4 inch (101.6 mm) tube: 150 mm flange 6 mm thick with a 102.2 mm bore, a 25 mm long collar with a 4 mm wall to slip over the tube, a 6 mm grub screw boss 12 mm across on the collar, and 6 holes of 9 mm on a 130 mm bolt circle
let tube_d = 101.6; // [76.2, 152.4] Tube outside diameter (mm)
let flange_d = 150.0; // [110.0, 210.0] Flange diameter (mm)
let flange_t = 6.0; // [4.0, 10.0] Flange thickness (mm)
let collar_len = 25.0; // [15.0, 40.0] Collar length (mm)
let bolts = 6; // [4, 8] Number of bolt holes
const wall = 4.0;
const bolt_d = 9.0;
let rb = tube_d / 2.0 + 0.3;
let rc = rb + wall;
let rf = max(flange_d / 2.0, rc + 16.0);
let pcd_r = (rc + rf) / 2.0;
let boss = cylinder([0, 0, flange_t + collar_len / 2.0], "Y", 6.0, rc + 4.0);
let body = fuse_all([cylinder(rf, flange_t), cylinder([0, 0, flange_t - 0.5], "Z", rc, collar_len + 0.5), boss]);
let cutters = [cylinder([0, 0, -1.0], "Z", rb, flange_t + collar_len + 2.0), cylinder([0, rb - 2.0, flange_t + collar_len / 2.0], "Y", 3.0, wall + 8.0)];
for i in 0..bolts {
    let a = (i * 360.0 / bolts + 15.0) * PI() / 180.0;
    cutters.push(cylinder([pcd_r * cos(a), pcd_r * sin(a), -1.0], "Z", bolt_d / 2.0, flange_t + 2.0));
}
body - fuse_all(cutters)
