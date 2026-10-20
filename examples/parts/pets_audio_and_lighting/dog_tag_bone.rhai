// Bone-shaped pet ID tag: 38 x 22 x 2 mm with a 4 mm ring hole and a 0.5 mm deep name panel
let len = 38.0; // [25.0, 50.0] Tag length (mm)
const r = 5.5;
let tag = box_centered(len - 2.0 * r, 12.0, 2.0).translate([0, 0, 1.0]);
for x in [-1.0, 1.0] { for y in [-1.0, 1.0] { tag += cylinder([x * (len / 2.0 - r), y * 5.5, 0], "Z", r, 2.0); } }
tag - cylinder([-len / 2.0 + 3.5, 0, -1], "Z", 2.0, 4.0) - box_centered(len - 18.0, 9.0, 1.0).translate([1.5, 0, 2.0])
