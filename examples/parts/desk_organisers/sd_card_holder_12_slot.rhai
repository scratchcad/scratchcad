// SD card holder, 12 slots: two staggered rows of 6 slots 2.6 x 24.6 mm, 16 mm deep for 32 x 24 x 2.1 mm SD cards, 3 mm between slots, cards stand 16 mm proud, 1.5 mm rounded top edge, 6 microSD slots along the front
let per_row = 6; // [3, 10] Slots per row
let slot_t = 2.6; // [2.3, 3.2] Slot thickness (mm)
let slot_l = 24.6; // [24.2, 26.0] Slot length (mm)
let slot_d = 16.0; // [10.0, 22.0] Slot depth (mm)
let gap = 3.0; // [2.0, 5.0] Gap between slots (mm)
let micro = 6; // [0, 10] Number of microSD slots

const base_t = 3.0;
const row_gap = 6.0;
let pitch = slot_t + gap;
let width = per_row * pitch + gap + pitch / 2.0;
let depth = 2.0 * slot_l + row_gap + 2.0 * gap + 14.0;
let h = slot_d + base_t;
let block = box_from_corners([0, 0, 0], [width, depth, h]);
block = block.fillet(4.0, block.edges("|Z"));
block = block.fillet(1.5, block.edges(">Z"));
let cuts = [];
for row in 0..2 {
    let y0 = 14.0 + gap + row * (slot_l + row_gap);
    let off = row * pitch / 2.0;
    for i in 0..per_row {
        let x = gap + off + i * pitch;
        cuts.push(box_from_corners([x, y0, base_t], [x + slot_t, y0 + slot_l, h + 1.0]));
    }
}
// microSD (15 x 11 x 1 mm) slots across the front strip
let nm = min(micro, ((width - 2.0 * gap) / 3.5).to_int());
let mp = (width - 2.0 * gap) / max(nm, 1);
for i in 0..nm {
    let x = gap + i * mp + mp / 2.0;
    cuts.push(box_from_corners([x - 0.7, 2.0, h - 9.0], [x + 0.7, 13.5, h + 1.0]));
}
block - compound(cuts)
