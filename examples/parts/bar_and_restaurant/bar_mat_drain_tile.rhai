// Interlocking bar mat tile: 150 x 150 x 10 mm grid of 8 mm square drains, 3 mm ribs, 4 dovetail edge tabs
let size = 150.0; // [100.0, 300.0] Tile size (mm)
let t = 10.0; // [6.0, 15.0] Thickness (mm)
let hole = 8.0; // [5.0, 12.0] Drain size (mm)
let pitch = hole + 3.0;
let tile = box_from_corners([0, 0, 0], [size, size, t]);
let holes = [];
let n = ((size - 6.0) / pitch).floor().to_int();
for i in 0..n { for j in 0..n { holes.push(box_from_corners([4.5 + i.to_float() * pitch, 4.5 + j.to_float() * pitch, -1], [4.5 + i.to_float() * pitch + hole, 4.5 + j.to_float() * pitch + hole, t + 1.0])); } }
tile - compound(holes)
