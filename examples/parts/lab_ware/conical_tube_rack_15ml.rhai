// Rack for 20 x 15 ml conical tubes: 5 x 4 grid at 25 mm pitch, 17.5 mm holes in a 3 mm deck 70 mm up, 8 mm locating holes in the base
let cols = 5; // [3, 10] Columns
let rows = 4; // [2, 6] Rows
const pitch = 25.0;
let w = cols.to_float() * pitch + 10.0;
let d = rows.to_float() * pitch + 10.0;
let deck = box_from_corners([0, 0, 70.0], [w, d, 73.0]);
let base = box_from_corners([0, 0, 0], [w, d, 4.0]);
let legs = [];
for x in [0.0, w - 4.0] { for y in [0.0, d - 4.0] { legs.push(box_from_corners([x, y, 0], [x + 4.0, y + 4.0, 73.0])); } }
let rack = fuse_all([deck, base] + legs);
let holes = [];
for i in 0..cols { for j in 0..rows {
    let x = 5.0 + pitch / 2.0 + i.to_float() * pitch;
    let y = 5.0 + pitch / 2.0 + j.to_float() * pitch;
    holes.push(cylinder([x, y, 69.0], "Z", 8.75, 5.0));
    holes.push(cylinder([x, y, 2.0], "Z", 4.0, 3.0));
} }
rack - fuse_all(holes)
