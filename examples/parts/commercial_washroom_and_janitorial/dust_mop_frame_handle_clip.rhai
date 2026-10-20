// Dust mop frame handle clip: a 5 mm thick base 60 x 30 mm with two 5 mm rivet holes 40 mm apart, a 29.4 mm round clamp collar 30 mm long standing 12 mm off the base on a web for a 22 mm handle (22.4 mm bore), split along the top by a 3 mm slot through a 12 mm wide clamp ear block with an M5 hole (5.5 mm)
let handle_d = 22.0; // [18.0, 28.0] Handle diameter (mm)
let base_len = 60.0; // [45.0, 90.0] Base length (mm)
let collar_len = 30.0; // [20.0, 45.0] Collar length (mm)
let standoff = 12.0; // [6.0, 25.0] Collar height above the base (mm)
const t = 5.0;
const wall = 3.5;
const w = 30.0;
let rb = handle_d / 2.0 + 0.2;
let ro = rb + wall;
let zc = t + standoff + ro;
let base = box_centered(base_len, w, t).translate([0, 0, t / 2.0]);
let base = base.fillet(4.0, base.edges("|Z"));
let cl = min(collar_len, base_len);
let collar = cylinder([-cl / 2.0, 0, zc], "X", ro, cl);
let web = box_centered(cl, 10.0, zc - t).translate([0, 0, t + (zc - t) / 2.0 - 0.5]);
let ears = box_centered(min(cl, 20.0), 12.0, 10.0).translate([0, 0, zc + ro + 3.0]);
let body = fuse_all([base, collar, web, ears]);
let hs = min(40.0, base_len - 12.0);
let cuts = [
    cylinder([-cl, 0, zc], "X", rb, 2.0 * cl),
    box_centered(cl + 2.0, 3.0, ro + 12.0).translate([0, 0, zc + ro / 2.0 + 4.0]),
    cylinder([0, -10.0, zc + ro + 4.0], "Y", 2.75, 20.0)
];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([s * hs / 2.0, 0, -1.0], "Z", 2.5, t + 2.0));
}
body - fuse_all(cuts)
