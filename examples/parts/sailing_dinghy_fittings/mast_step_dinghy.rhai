// Dinghy mast step: 80 x 60 mm base 6 mm, 40 x 30 mm oval socket 25 mm deep for an oval mast heel, 4 screw holes, drain slot
let length = 80.0; // [60.0, 120.0] Base length (mm)
let width = 60.0; // [45.0, 90.0] Base width (mm)
let mast_l = 40.0; // [30.0, 60.0] Mast heel length (mm)
let mast_w = 30.0; // [20.0, 36.0] Mast heel width (mm)
let base = box_centered(length, width, 6.0).translate([0, 0, 3.0]);
let b = base.fillet(10.0, base.edges("|Z"));
let socket = box_centered(mast_l + 8.0, mast_w + 8.0, 25.0).translate([0, 0, 12.5]);
let s = socket.fillet(mast_w / 2.0 + 3.9, socket.edges("|Z"));
let hole = box_centered(mast_l, mast_w, 30.0).translate([0, 0, 18.0]);
let h = hole.fillet(mast_w / 2.0 - 0.1, hole.edges("|Z"));
let holes = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * (length / 2.0 - 8.0), sy * (width / 2.0 - 8.0), -1], "Z", 2.5, 8.0)); } }
b + s - h - compound(holes) - box_centered(mast_l + 20.0, 4.0, 3.0).translate([0, 0, 4.5])
