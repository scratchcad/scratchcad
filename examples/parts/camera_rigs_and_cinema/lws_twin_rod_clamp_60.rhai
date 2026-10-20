// LWS twin rod clamp for 15 mm rods on 60 mm centres: 95 x 22 x 25 mm block, 15.1 mm rod bores split out to the ends with 1.5 mm slots and vertical M4 pinch bolts (4.4 mm) across each split, 1/4-20 tapped hole (5.1 mm core) and two 3/8-16 tapped holes (8 mm core) 12 mm deep in the top face
let rod_d = 15.0; // [12.0, 19.0] Rod diameter (mm)
let spacing = 60.0; // [50.0, 70.0] Rod centre spacing (mm)
let depth = 22.0; // [15.0, 40.0] Clamp depth along the rods (mm)
let length = spacing + rod_d + 20.0;
let height = rod_d + 10.0;
let zc = rod_d / 2.0 + 3.5;
let block = box_centered(length, depth, height).translate([0, 0, height / 2.0]);
let block = block.fillet(3.0, block.edges("|Y"));
let cuts = [];
for s in [-1.0, 1.0] {
    let x = s * spacing / 2.0;
    cuts.push(cylinder([x, -depth, zc], "Y", rod_d / 2.0 + 0.05, depth * 2.0));
    cuts.push(box_from_corners([x, -depth, zc - 0.75], [s * (length / 2.0 + 1.0), depth, zc + 0.75]));
    cuts.push(cylinder([s * (spacing / 2.0 + rod_d / 2.0 + 4.5), 0, -1.0], "Z", 2.2, height + 2.0));
}
cuts.push(cylinder([0, 0, height - 12.0], "Z", 2.55, 13.0));
let hx = spacing / 2.0 - rod_d / 2.0 - 6.0;
for s in [-1.0, 1.0] {
    cuts.push(cylinder([s * hx, 0, height - 12.0], "Z", 4.0, 13.0));
}
block - fuse_all(cuts)
