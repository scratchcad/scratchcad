// Test tube rack for 12 x 16 mm tubes: 2 rows of 6 at 22 mm pitch, 17 mm holes in the top tier, 10 mm holes in the middle tier, 3 mm panels
let n = 6; // [3, 12] Tubes per row
let tube = 16.0; // [10.0, 25.0] Tube diameter (mm)
let pitch = tube + 6.0;
let len = n.to_float() * pitch + 10.0;
let base = box_from_corners([0, 0, 0], [len, 50.0, 3.0]);
let top = box_from_corners([0, 0, 60.0], [len, 50.0, 63.0]);
let mid = box_from_corners([0, 0, 30.0], [len, 50.0, 33.0]);
let ends = [box_from_corners([0, 0, 0], [3.0, 50.0, 63.0]), box_from_corners([len - 3.0, 0, 0], [len, 50.0, 63.0])];
let rack = fuse_all([base, top, mid] + ends);
let holes = [];
for i in 0..n { for y in [14.0, 36.0] {
    let x = 5.0 + pitch / 2.0 + i.to_float() * pitch;
    holes.push(cylinder([x, y, 59.0], "Z", tube / 2.0 + 0.5, 5.0));
    holes.push(cylinder([x, y, 29.0], "Z", tube / 2.0 - 3.0, 5.0));
} }
rack - fuse_all(holes)
