// Kart floor tray saddle clamp for a 28 mm frame tube: 30 x 44 x 20 mm block with a 28 mm half-round groove on top for the tube, two M5 holes (5.3 mm) beside the groove for a strap, a flat base for the floor tray with an M6 tapped hole (5 mm core) from below and 1.5 mm chamfered vertical edges
let tube_d = 28.0; // [20.0, 32.0] Frame tube diameter (mm)
let length = 30.0; // [20.0, 45.0] Clamp length (mm)
let tray_gap = 6.0; // [4.0, 15.0] Floor tray gap under the tube (mm)
let w = tube_d + 16.0;
let zc = tray_gap + tube_d / 2.0;
let h = zc;
let block = box_centered(length, w, h).translate([0, 0, h / 2.0]);
let block = block.chamfer(1.5, block.edges("|Z"));
let cuts = [cylinder([-length / 2.0 - 1.0, 0, zc], "X", tube_d / 2.0 + 0.2, length + 2.0)];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([0, s * (tube_d / 2.0 + 4.2), -1.0], "Z", 2.65, h + 2.0));
}
cuts.push(cylinder([0, 0, -1.0], "Z", 2.5, min(10.0, tray_gap + 3.0)));
block - fuse_all(cuts)
