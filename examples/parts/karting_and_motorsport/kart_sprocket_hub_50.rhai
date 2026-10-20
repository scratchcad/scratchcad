// Kart rear sprocket hub for a 50 mm axle: 95 mm flange 8 mm thick with six M6 tapped holes (5 mm core) on an 82 mm PCD, 70 mm boss 30 mm long, 50 mm bore with an 8 mm keyway 4 mm deep, two M8 grub screw holes (6.8 mm) at 90 degrees and 1 mm chamfers
let axle_d = 50.0; // [30.0, 50.0] Axle diameter (mm)
let pcd = 82.0; // [70.0, 95.0] Sprocket bolt circle (mm)
let hub_len = 30.0; // [20.0, 45.0] Hub length (mm)
let bolts = 6; // [3, 8] Number of sprocket bolts
const flange_t = 8.0;
const key = 8.0;
let p = max(pcd, axle_d + 27.0);
let fr = p / 2.0 + 6.5;
let br = axle_d / 2.0 + 10.0;
let boss = cylinder([0, 0, 0], "Z", br, hub_len);
let boss = boss.chamfer(1.0, boss.edges(">Z"));
let flange = cylinder([0, 0, 0], "Z", fr, flange_t);
let flange = flange.chamfer(1.0, flange.edges("<Z"));
let body = boss + flange;
let cuts = [
    cylinder([0, 0, -1.0], "Z", axle_d / 2.0, hub_len + 2.0),
    box_from_corners([-key / 2.0, 0, -1.0], [key / 2.0, axle_d / 2.0 + 4.0, hub_len + 1.0]),
    cylinder([0, 0, (hub_len + flange_t) / 2.0], "X", 3.4, br + 2.0),
    cylinder([0, 0, (hub_len + flange_t) / 2.0], "-Y", 3.4, br + 2.0)
];
for i in 0..bolts {
    let a = (i.to_float() * 360.0 / bolts.to_float() + 30.0) * PI() / 180.0;
    cuts.push(cylinder([p / 2.0 * cos(a), p / 2.0 * sin(a), -1.0], "Z", 2.5, flange_t + 2.0));
}
body - fuse_all(cuts)
