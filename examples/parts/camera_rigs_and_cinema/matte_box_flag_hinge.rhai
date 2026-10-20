// Matte box top flag hinge block: 40 x 16 x 10 mm body with 2 mm edge rounds, 5 mm hinge pin bore along the back, 2.2 mm thick flag slot 7.5 mm deep along the front clamped by two M3 countersunk screws (3.2 mm) on 26 mm, and an M4 friction-screw hole (3.3 mm) down into the pin bore
let length = 40.0; // [30.0, 80.0] Hinge length (mm)
let flag_t = 2.2; // [1.5, 3.5] Flag panel thickness (mm)
let pin_d = 5.0; // [3.0, 6.0] Hinge pin diameter (mm)
const depth = 16.0;
const height = 10.0;
let yb = -depth / 2.0 + 3.5;
let ys = depth / 2.0 - 3.5;
let body = box_centered(length, depth, height).translate([0, 0, height / 2.0]);
let body = body.fillet(2.0, body.edges("|X"));
let barrel = cylinder([-length / 2.0 - 1.0, yb, height / 2.0], "X", pin_d / 2.0 + 0.1, length + 2.0);
let slot = box_from_corners([-length / 2.0 - 1.0, depth / 2.0 - 7.5, height / 2.0 - flag_t / 2.0], [length / 2.0 + 1.0, depth / 2.0 + 1.0, height / 2.0 + flag_t / 2.0]);
let cuts = [barrel, slot];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([s * 13.0, ys, -1.0], "Z", 1.6, height + 2.0));
    cuts.push(cone(1.6, 3.2, 1.6).translate([s * 13.0, ys, height - 1.6 + 0.01]));
}
let friction = cylinder([0, yb, height / 2.0], "Z", 1.65, height);
body - fuse_all(cuts) - friction
