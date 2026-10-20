// Barrel bolt keeper: 40 x 20 mm base 3 mm thick with a 12 x 15 mm keeper block bored 10.5 mm for a 10 mm bolt, two 4 mm countersunk screw holes
let bolt = 10.0; // [6.0, 14.0] Bolt diameter (mm)
let base_l = 40.0; // [32.0, 60.0] Base length (mm)
const t = 3.0;
let block_h = bolt + 6.0;
let base = box_centered(base_l, 20.0, t).translate([0, 0, t / 2.0]);
let block = box_centered(15.0, 20.0, block_h).translate([0, 0, t + block_h / 2.0 - 0.01]);
let k = base + block - cylinder([-10.0, 0, t + block_h / 2.0], "X", bolt / 2.0 + 0.25, 20.0);
let holes = [];
for x in [-base_l / 2.0 + 6.0, base_l / 2.0 - 6.0] {
    holes.push(cylinder([x, 0, -1.0], "Z", 2.0, t + 2.0));
    holes.push(cone(2.0, 4.0, 2.0).translate([x, 0, t - 1.99]));
}
k - fuse_all(holes)
