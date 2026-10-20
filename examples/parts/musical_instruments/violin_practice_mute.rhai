// Violin practice mute: 38 x 32 x 15 mm comb with 3 slots 1.3 mm for the bridge, 22 mm deep
let width = 38.0; // [30.0, 50.0] Width (mm)
let height = 32.0; // [25.0, 40.0] Height (mm)
let depth = 15.0; // [10.0, 20.0] Depth (mm)
let slot_d = 22.0; // [15.0, 28.0] Slot depth (mm)
let block = box_centered(width, depth, height).translate([0, 0, height / 2.0]);
let b = block.fillet(4.0, block.edges("|Y"));
let slots = [];
for x in [-9.0, 0.0, 9.0] { slots.push(box_from_corners([x - 0.65, -depth, -1], [x + 0.65, depth, slot_d])); }
b - compound(slots)
