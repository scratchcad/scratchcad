// Stitching hole spacing guide: 100 x 20 x 4 mm strip with 3.85 mm (SPI 6.6) and 4 mm pitch rows of 1.5 mm holes
let length = 100.0; // [60.0, 150.0] Length (mm)
let t = 4.0; // [2.0, 6.0] Thickness (mm)
let strip = box_from_corners([0, 0, 0], [length, 20.0, t]);
let s = strip.fillet(3.0, strip.edges("|Z"));
let holes = [];
let n1 = ((length - 10.0) / 3.85).floor().to_int();
for i in 0..=n1 { holes.push(cylinder([5.0 + i.to_float() * 3.85, 6.0, -1], "Z", 0.75, t + 2.0)); }
let n2 = ((length - 10.0) / 4.0).floor().to_int();
for i in 0..=n2 { holes.push(cylinder([5.0 + i.to_float() * 4.0, 14.0, -1], "Z", 0.75, t + 2.0)); }
s - compound(holes)
