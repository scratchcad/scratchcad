// Kart engine chain adjuster: 6 mm base 55 x 25 mm with an 8.5 mm M8 slot 15 mm long to clamp to the engine mount, and a 20 mm thick upright block 22 mm tall at one end with an M8 tapped hole (6.8 mm core) along the slide for the tension bolt, 1 mm chamfers on the block
let base_len = 55.0; // [40.0, 80.0] Base length (mm)
let width = 25.0; // [20.0, 35.0] Adjuster width (mm)
let block_h = 22.0; // [16.0, 35.0] Block height (mm)
let slot_len = 15.0; // [0.0, 20.0] Clamp slot travel (mm)
const base_t = 6.0;
const block_t = 20.0;
let base = box_from_corners([0, -width / 2.0, 0], [base_len, width / 2.0, base_t]);
let base = base.fillet(3.0, base.edges("|Z and >X"));
let block = box_from_corners([0, -width / 2.0, 0], [block_t, width / 2.0, block_h]);
let block = block.chamfer(1.0, block.edges(">Z"));
let body = base + block;
let xs = block_t + (base_len - block_t) / 2.0;
let sl = min(slot_len, base_len - block_t - 18.0);
let zb = base_t + (block_h - base_t) / 2.0 + 1.0;
let cuts = [
    cylinder([-1.0, 0, zb], "X", 3.4, block_t + 2.0),
    cylinder([xs - sl / 2.0, 0, -1.0], "Z", 4.25, base_t + 2.0),
    cylinder([xs + sl / 2.0, 0, -1.0], "Z", 4.25, base_t + 2.0)
];
if sl > 0.5 {
    cuts.push(box_centered(sl, 8.5, base_t + 2.0).translate([xs, 0, base_t / 2.0]));
}
body - fuse_all(cuts)
