// Bead loom warp comb end: 120 mm long, 20 mm tall comb with 2 mm pitch (11/0 seed beads) 0.6 mm slots 6 mm deep
let length = 120.0; // [80.0, 200.0] Comb length (mm)
let pitch = 2.0; // [1.6, 4.0] Slot pitch (mm)
let height = 20.0; // [12.0, 30.0] Comb height (mm)
let t = 5.0; // [3.0, 8.0] Thickness (mm)
let comb = box_from_corners([0, 0, 0], [length, t, height]);
let slots = [];
let n = ((length - 10.0) / pitch).floor().to_int();
for i in 0..n { slots.push(box_from_corners([5.0 + i.to_float() * pitch - 0.3, -1, height - 6.0], [5.0 + i.to_float() * pitch + 0.3, t + 1.0, height + 1.0])); }
comb - compound(slots) - cylinder([10.0, -1, 6.0], "Y", 2.0, t + 2.0) - cylinder([length - 10.0, -1, 6.0], "Y", 2.0, t + 2.0)
