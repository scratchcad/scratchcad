// Nutrient dosing syringe rack for three 60 ml syringes (29 mm barrels): 120 x 40 x 25 mm block with three 30 mm through holes on 38 mm centres, each with a 37 x 13 mm finger-flange pocket 3 mm deep on top, and a 3 mm back plate 60 mm tall with two 4.5 mm wall screw holes
let barrel_d = 30.0; // [15.0, 35.0] Barrel hole diameter (mm)
let syringes = 3; // [1, 6] Number of syringe holders
let block_h = 25.0; // [15.0, 40.0] Block height (mm)
const depth = 40.0;
const plate_t = 3.0;
const plate_h = 60.0;
let pitch = barrel_d + 8.0;
let len = pitch * syringes.to_float() + 6.0;
let block = box_from_corners([-len / 2.0, 0, 0], [len / 2.0, depth, block_h]);
let block = block.fillet(3.0, block.edges("|Z and >Y"));
let plate = box_from_corners([-len / 2.0, -plate_t, 0], [len / 2.0, 0.5, plate_h]);
let body = block + plate;
let fw = min(barrel_d + 14.0, pitch - 1.0);
let cuts = [];
for i in 0..syringes {
    let x = -len / 2.0 + 3.0 + pitch * (i.to_float() + 0.5);
    cuts.push(cylinder([x, depth / 2.0 + 1.0, -1.0], "Z", barrel_d / 2.0, block_h + 2.0));
    cuts.push(box_from_corners([x - fw / 2.0, depth / 2.0 + 1.0 - 6.0, block_h - 3.0], [x + fw / 2.0, depth / 2.0 + 7.0, block_h + 1.0]));
}
for s in [-1.0, 1.0] {
    cuts.push(cylinder([s * (len / 2.0 - 12.0), -plate_t - 1.0, plate_h - 12.0], "Y", 2.25, plate_t + 2.0));
}
(body - fuse_all(cuts)).mirror("XZ")
