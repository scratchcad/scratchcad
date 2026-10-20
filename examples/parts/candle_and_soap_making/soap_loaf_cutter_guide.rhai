// Soap loaf cutting guide: 300 mm long U-cradle for a 90 mm wide loaf, 15 mm walls 80 mm tall with blade slots 1.5 mm wide every 25 mm and an adjustable end stop slot
let loaf_w = 90.0; // [60.0, 120.0] Loaf width (mm)
let pitch = 25.0; // [15.0, 40.0] Slice thickness (mm)
const length = 300.0;
const wall = 15.0;
let c = box_from_corners([0, 0, 0], [length, loaf_w + 2.0 * wall, 80.0]) - box_from_corners([-1.0, wall, 10.0], [length + 1.0, loaf_w + wall, 81.0]);
let n = ((length - 20.0) / pitch).to_int();
let slots = [];
for i in 1..=n { slots.push(box_from_corners([10.0 + i.to_float() * pitch - 0.75, -1.0, 15.0], [10.0 + i.to_float() * pitch + 0.75, loaf_w + 2.0 * wall + 1.0, 81.0])); }
c - fuse_all(slots) - box_from_corners([5.0, loaf_w / 2.0 + wall - 3.0, -1.0], [length * 0.3, loaf_w / 2.0 + wall + 3.0, 11.0])
