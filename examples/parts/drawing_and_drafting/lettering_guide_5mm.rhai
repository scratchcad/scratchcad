// Lettering stencil guide strip: 200 x 30 x 1.2 mm with 5 mm line slots and a 10 mm guideline row
let length = 200.0; // [120.0, 300.0] Length (mm)
let width = 30.0; // [20.0, 40.0] Width (mm)
let thickness = 1.2; // [0.8, 2.0] Thickness (mm)
let pitch = 5.0; // [3.0, 10.0] Line pitch (mm)
let strip = box(length, width, thickness);
let s = strip.fillet(3.0, strip.edges("|Z"));
let slots = [];
for k in 0..3 { slots.push(box_from_corners([10.0, 6.0 + k.to_float() * pitch, -1], [length - 10.0, 6.8 + k.to_float() * pitch, thickness + 1.0])); }
s - compound(slots)
