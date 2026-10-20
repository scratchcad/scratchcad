// Class 1 lever demo: 200 x 20 x 6 mm beam with 8 holes at 20 mm pitch, triangular fulcrum stand 40 mm tall
let length = 200.0; // [100.0, 300.0] Beam length (mm)
let pitch = 20.0; // [10.0, 30.0] Hole pitch (mm)
let height = 40.0; // [20.0, 80.0] Fulcrum height (mm)
let beam = box_from_corners([-length / 2.0, -10.0, height], [length / 2.0, 10.0, height + 6.0]);
let n = (length / pitch).floor().to_int();
let stand = polygon([[-25.0, 0], [25.0, 0], [3.0, height - 3.0], [-3.0, height - 3.0]]).to_face().extrude([0, 0, 20.0]).rotate_x(90.0).translate([0, 10.0, 0]);
let pivot = cylinder([0, -10.0, height - 2.0], "Y", 3.0, 20.0);
let bh = [];
for k in 1..n { if k != n / 2 { bh.push(cylinder([-length / 2.0 + k.to_float() * pitch, 0, height - 1.0], "Z", 2.0, 8.0)); } }
beam - fuse_all(bh) + stand + pivot
