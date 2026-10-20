// Desk ruler and set-square stand: 130 x 60 x 45 mm block with 6 slots 4 mm wide and 35 mm deep leaning back 10 degrees, 36 mm long slots, 10 mm solid base with a 2 mm felt pad recess underneath
let length = 130.0; // [80.0, 200.0] Stand length (mm)
let slots = 6; // [3, 10] Number of slots
let slot_w = 4.0; // [2.5, 8.0] Slot width (mm)
let slot_d = 35.0; // [20.0, 45.0] Slot depth (mm)
let lean = 10.0; // [0.0, 20.0] Lean back (degrees)

const depth = 60.0;
const base_t = 10.0;
let h = slot_d + base_t;
let block = box_from_corners([0, 0, 0], [length, depth, h]);
block = block.fillet(6.0, block.edges("|Z"));
block = block.fillet(3.0, block.edges(">Z"));
let pitch = length / slots;
let cuts = [];
for i in 0..slots {
    let x = (i + 0.5) * pitch;
    let s = box_from_corners([x - slot_w / 2.0, 12.0, 0], [x + slot_w / 2.0, depth - 12.0, slot_d + 20.0]).rotate([x, depth / 2.0, base_t], "X", -lean).translate([0, 0, base_t]);
    cuts.push(s);
}
block = block - fuse_all(cuts);
block - box_from_corners([-1.0, 12.0, -1.0], [length + 1.0, depth - 12.0, 2.0])
