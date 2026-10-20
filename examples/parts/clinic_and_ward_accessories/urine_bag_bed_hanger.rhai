// Catheter urine bag bed-frame hanger: 25 mm wide hook that drops over a 32 mm bed frame rail, 4 mm thick, with a 90 mm drop and two 8 mm pegs 60 mm apart for the bag's hanging eyelets
let rail = 32.0; // [20.0, 50.0] Bed frame rail depth (mm)
let drop = 90.0; // [60.0, 140.0] Drop to the pegs (mm)
let peg_gap = 60.0; // [40.0, 80.0] Peg spacing (mm)
const t = 4.0;
const w = 25.0;
let hook = fuse_all([
    box_from_corners([-w / 2.0, 0, -drop], [w / 2.0, t, t]),
    box_from_corners([-w / 2.0, 0, 0], [w / 2.0, rail + 2.0 * t, t]),
    box_from_corners([-w / 2.0, rail + t, -20.0], [w / 2.0, rail + 2.0 * t, t]),
    box_from_corners([-peg_gap / 2.0 - 8.0, 0, -drop], [peg_gap / 2.0 + 8.0, t, -drop + 20.0]),
]);
let pegs = [];
for sx in [-1.0, 1.0] {
    pegs.push(cylinder([sx * peg_gap / 2.0, 0.01, -drop + 10.0], "-Y", 4.0, 12.0) + cylinder([sx * peg_gap / 2.0, -10.0, -drop + 10.0], "-Y", 5.5, 2.5));
}
hook + fuse_all(pegs)
