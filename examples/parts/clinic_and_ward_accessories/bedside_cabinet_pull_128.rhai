// Bedside cabinet D-pull handle: 128 mm hole centres, 150 mm bar 14 x 10 mm with 3 mm rounded edges, standing 32 mm proud on two 14 mm square legs with 3.3 mm M4 tap holes 12 mm deep
let centres = 128.0; // [64.0, 192.0] Hole centres (mm)
let proud = 32.0; // [22.0, 45.0] Handle projection (mm)
let bar_w = 14.0; // [10.0, 20.0] Bar width (mm)
const bar_t = 10.0;
let len = centres + 22.0;
let bar = box_from_corners([-len / 2.0, -bar_w / 2.0, proud - bar_t], [len / 2.0, bar_w / 2.0, proud]);
bar = bar.fillet(3.0, bar.edges("|X and >Z"));
let legs = [];
for sx in [-1.0, 1.0] {
    legs.push(box_from_corners([sx * centres / 2.0 - 7.0, -7.0, 0], [sx * centres / 2.0 + 7.0, 7.0, proud - bar_t + 1.0]));
}
let h = bar + fuse_all(legs);
h - cylinder([-centres / 2.0, 0, -1.0], "Z", 1.65, 13.0) - cylinder([centres / 2.0, 0, -1.0], "Z", 1.65, 13.0)
