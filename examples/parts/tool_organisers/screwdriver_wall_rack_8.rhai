// Screwdriver wall rack: 8 slots 8 mm wide opening into 16 mm holes for handles up to 30 mm, on a 40 mm pitch, 340 x 40 x 15 mm shelf with a 40 mm backplate and four 4.5 mm screw holes
let slots = 8; // [4, 12] Number of screwdrivers
let shaft_hole = 16.0; // [10.0, 22.0] Shank hole diameter (mm)
const pitch = 40.0;
const t = 15.0;
let length = pitch * slots.to_float() + 20.0;
let shelf = box_from_corners([0, 0, 0], [length, 40.0, t]);
let back = box_from_corners([0, 40.0 - 5.0, 0], [length, 40.0, 40.0 + t]);
let cuts = [];
for i in 0..slots {
    let x = 10.0 + pitch * (i.to_float() + 0.5);
    cuts.push(cylinder([x, 18.0, -1.0], "Z", shaft_hole / 2.0, t + 2.0));
    cuts.push(box_from_corners([x - 4.0, -1.0, -1.0], [x + 4.0, 18.0, t + 1.0]));
}
for x in [20.0, length / 3.0, 2.0 * length / 3.0, length - 20.0] { cuts.push(cylinder([x, 30.0, t + 25.0], "Y", 2.25, 20.0)); }
shelf + back - fuse_all(cuts)
