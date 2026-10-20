// Paper towel dispenser cover hinge knuckle: a 3 mm leaf 40 x 25 mm with two 4 mm countersunk rivet holes (8 mm heads) 24 mm apart, a 10 mm knuckle 20 mm long along one edge with a 4.2 mm pin bore, joined to the leaf by a web
let leaf_w = 40.0; // [30.0, 60.0] Leaf width (mm)
let leaf_d = 25.0; // [18.0, 40.0] Leaf depth (mm)
let knuckle_d = 10.0; // [7.0, 14.0] Knuckle diameter (mm)
let knuckle_len = 20.0; // [10.0, 40.0] Knuckle length (mm)
let pin_d = 4.2; // [2.5, 6.0] Pin bore diameter (mm)
const t = 3.0;
let kr = knuckle_d / 2.0;
let kl = min(knuckle_len, leaf_w);
let leaf = box_from_corners([-leaf_w / 2.0, 0, 0], [leaf_w / 2.0, leaf_d, t]);
let leaf = leaf.fillet(3.0, leaf.edges("|Z and >Y"));
let knuckle = cylinder([-kl / 2.0, 0, kr], "X", kr, kl);
let web = box_from_corners([-kl / 2.0, 0, 0], [kl / 2.0, kr, kr]);
let body = fuse_all([leaf, knuckle, web]);
let pr = min(pin_d / 2.0, kr - 1.5);
let hs = min(24.0, leaf_w - 12.0);
let cuts = [cylinder([-leaf_w, 0, kr], "X", pr, 2.0 * leaf_w)];
for s in [-1.0, 1.0] {
    let p = [s * hs / 2.0, leaf_d - 8.0, -1.0];
    cuts.push(cylinder(p, "Z", 2.0, t + 2.0));
    cuts.push(cone(2.0, 4.0, 2.0).translate([s * hs / 2.0, leaf_d - 8.0, t - 1.99]));
}
body - fuse_all(cuts)
