// Medicine bottle opener: 70 mm knurled disc with three stepped sockets (28, 33 and 38 mm) 8 mm deep for child-resistant caps, rubber-style 24-rib rim, 30 mm tall
// # Disc
let diameter = 70.0; // [55.0, 90.0] Disc diameter (mm)
let height = 30.0; // [20.0, 40.0] Disc height (mm)
let grip_ribs = 24; // [12, 36] Number of grip ribs
// # Sockets
let cap_small = 28.0; // [20.0, 30.0] Smallest cap diameter (mm)
let step = 5.0; // [3.0, 8.0] Socket step (mm)
let socket_depth = 8.0; // [5.0, 12.0] Depth per step (mm)
let r = diameter / 2.0;
let disc = cylinder(r, height).chamfer(1.5);
let cuts = [];
for i in 0..grip_ribs {
    cuts.push(cylinder([r + 1.0, 0, 3.0], "Z", 2.0, height - 6.0).rotate_z(i.to_float() * 360.0 / grip_ribs.to_float()));
}
let sockets = [];
for k in 0..3 {
    let d = cap_small + k.to_float() * step;
    let dr = min(d / 2.0, r - 4.0);
    sockets.push(cylinder([0, 0, height - (3 - k).to_float() * socket_depth], "Z", dr, socket_depth * 3.0));
}
let teeth = [];
for i in 0..12 {
    teeth.push(box_centered(cap_small + 2.0, 1.0, socket_depth).rotate_z(i.to_float() * 15.0).translate([0, 0, height - 3.0 * socket_depth + socket_depth / 2.0]));
}
disc - fuse_all(cuts) - fuse_all(sockets) - fuse_all(teeth)
