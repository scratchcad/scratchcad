// Rebar wheel spacer, 40 mm cover: 92 mm wheel (2 x cover + bar) 4 mm thick with 8 spokes, a rim, a snap-in centre clip for 8-14 mm bars and an entry gap 7 mm
let cover = 40.0; // [20.0, 60.0] Concrete cover (mm)
let bar = 12.0; // [8.0, 16.0] Bar diameter (mm)
const t = 4.0;
let r = cover + bar / 2.0;
let rim = cylinder([0, 0, 0], "Z", r, t) - cylinder([0, 0, -1.0], "Z", r - 3.0, t + 2.0);
let hub = cylinder([0, 0, 0], "Z", bar / 2.0 + 3.0, t);
let spokes = [];
for i in 0..8 { spokes.push(box_from_corners([bar / 2.0 + 2.0, -1.5, 0], [r - 2.0, 1.5, t]).rotate_z(i.to_float() * 45.0 + 22.5)); }
rim + hub + fuse_all(spokes) - cylinder([0, 0, -1.0], "Z", bar / 2.0, t + 2.0) - box_from_corners([-bar * 0.3, 0, -1.0], [bar * 0.3, r + 1.0, t + 1.0])
