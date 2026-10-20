// Hand drill guide block: 80 x 40 x 30 mm block, 6 guide holes 3, 4, 5, 6, 8 and 10 mm, 90 degree V-groove underneath for drilling round stock
let length = 80.0; // [60.0, 120.0] Block length (mm)
let width = 40.0; // [30.0, 60.0] Block width (mm)
let height = 30.0; // [20.0, 45.0] Block height (mm)
let v_depth = 10.0; // [5.0, 15.0] V-groove depth (mm)
let blk = box_from_corners([0, 0, 0], [length, width, height]);
let b = blk.chamfer(1.0);
let sizes = [3.0, 4.0, 5.0, 6.0, 8.0, 10.0];
let step = (length - 16.0) / 5.0;
let holes = [];
for i in 0..6 { holes.push(cylinder([8.0 + i.to_float() * step, width / 2.0, -1], "Z", sizes[i] / 2.0 + 0.05, height + 2.0)); }
let vg = polygon([[-1, width / 2.0 - v_depth - 2.0, -2.0], [-1, width / 2.0 + v_depth + 2.0, -2.0], [-1, width / 2.0, v_depth]]).to_face().extrude([length + 2.0, 0, 0]);
b - compound(holes) - vg
