// Lens support for 15 mm LWS rods: rod block 86 x 20 x 26 mm on 60 mm centres with clamps split upwards and M4 pinch holes (4.4 mm) across the splits, 10 mm column with a 40 mm adjustable height slot (6.5 mm), V-cradle 50 mm wide with a 100 degree V for lenses 60 to 110 mm
let column_h = 50.0; // [30.0, 90.0] Column height above the rods (mm)
let cradle_w = 50.0; // [40.0, 80.0] Cradle width (mm)
let spacing = 60.0; // [50.0, 70.0] Rod spacing (mm)
const rod_d = 15.0;
const depth = 20.0;
const blk_h = 26.0;
let length = spacing + rod_d + 11.0;
const zr = 9.0;
let block = box_from_corners([-length / 2.0, -depth / 2.0, 0], [length / 2.0, depth / 2.0, blk_h]);
let block = block.fillet(3.0, block.edges("|Y"));
let cuts = [];
for s in [-1.0, 1.0] {
    let x = s * spacing / 2.0;
    cuts.push(cylinder([x, -depth, zr], "Y", rod_d / 2.0 + 0.05, depth * 2.0));
    cuts.push(box_from_corners([x - 0.75, -depth, zr], [x + 0.75, depth, blk_h + 1.0]));
    cuts.push(cylinder([x - 10.0, 0, blk_h - 4.5], "X", 2.2, 20.0));
}
let column = box_from_corners([-12.0, -5.0, blk_h - 0.5], [12.0, 5.0, blk_h + column_h]);
let slot_len = column_h - 16.0;
let slot = box_from_corners([-3.25, -6.0, blk_h + 6.0], [3.25, 6.0, blk_h + 6.0 + slot_len]);
let zt = blk_h + column_h;
let vh = cradle_w / 2.0 / tan(50.0 * PI() / 180.0);
let cradle = face(polygon([[-cradle_w / 2.0, -5.0, zt - 0.5], [cradle_w / 2.0, -5.0, zt - 0.5], [cradle_w / 2.0, -5.0, zt + vh + 4.0], [0, -5.0, zt + 4.0], [-cradle_w / 2.0, -5.0, zt + vh + 4.0]])).extrude([0, 10.0, 0]);
block + column + cradle - fuse_all(cuts) - slot
