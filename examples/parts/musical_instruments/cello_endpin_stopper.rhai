// Cello endpin anchor disc: 80 mm rubber-backed disc, 15 mm tall, 10 mm cup for the endpin, strap slot
let diameter = 80.0; // [50.0, 120.0] Disc diameter (mm)
let height = 15.0; // [8.0, 25.0] Height (mm)
let cup = 10.0; // [6.0, 14.0] Endpin cup diameter (mm)
let disc = cylinder(diameter / 2.0, height);
let d = disc.fillet(5.0, disc.edges(">Z"));
let pockets = [];
for r in [0.0, 12.0] { pockets.push(cylinder([r, 0, height - 6.0], "Z", cup / 2.0, 7.0) + sphere([r, 0, height - 6.0], cup / 2.0)); }
d - fuse_all(pockets) - box_from_corners([-diameter / 2.0 + 8.0, -12.0, -1], [-diameter / 2.0 + 12.0, 12.0, height * 0.6])
