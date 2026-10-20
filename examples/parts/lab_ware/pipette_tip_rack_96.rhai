// 96-position 200 ul pipette tip rack: 128 x 86 x 50 mm box, 1.5 mm walls, 2 mm deck with 6.6 mm holes on a 9 mm grid
const pitch = 9.0;
let hole = 6.6; // [4.0, 8.0] Hole diameter (mm)
let rack = box_centered(128.0, 86.0, 50.0).translate([0, 0, 25.0]) - box_centered(125.0, 83.0, 50.0).translate([0, 0, 22.0]);
let holes = [];
for i in 0..12 { for j in 0..8 { holes.push(cylinder([(i.to_float() - 5.5) * pitch, (j.to_float() - 3.5) * pitch, 45.0], "Z", hole / 2.0, 10.0)); } }
rack - fuse_all(holes)
