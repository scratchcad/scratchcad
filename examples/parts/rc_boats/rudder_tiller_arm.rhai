// RC boat rudder tiller arm: 25 mm arm 3 mm thick on an 8 mm hub bored 3 mm with an M3 set screw, and three 1.5 mm pushrod holes at 15, 19 and 23 mm
let arm = 25.0; // [18.0, 35.0] Arm length (mm)
let shaft = 3.0; // [2.0, 4.0] Rudder shaft diameter (mm)
const t = 3.0;
let hub = cylinder([0, 0, 0], "Z", 4.0, 8.0);
let a = box_from_corners([0, -3.0, 0], [arm, 3.0, t]) + cylinder([arm, 0, 0], "Z", 3.0, t);
let holes = [cylinder([0, 0, -1.0], "Z", shaft / 2.0 + 0.05, 10.0), cylinder([0, -5.0, 5.5], "Y", 1.25, 5.0)];
for d in [arm - 10.0, arm - 6.0, arm - 2.0] { holes.push(cylinder([d, 0, -1.0], "Z", 0.75, t + 2.0)); }
hub + a - fuse_all(holes)
