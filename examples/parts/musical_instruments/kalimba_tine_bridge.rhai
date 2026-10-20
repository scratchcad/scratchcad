// 17-key kalimba tine bridge: 130 mm, 8 x 6 mm triangular saddle on a 12 x 4 mm base, 2 M3 holes
let length = 130.0; // [80.0, 160.0] Length (mm)
let base_w = 12.0; // [8.0, 16.0] Base width (mm)
let base_t = 4.0; // [2.0, 6.0] Base thickness (mm)
let saddle_h = 6.0; // [3.0, 10.0] Saddle height (mm)
let base = box_centered(length, base_w, base_t).translate([0, 0, base_t / 2.0]);
let s = polygon([[-4.0, 0], [4.0, 0], [0, saddle_h]]).to_face().extrude([0, 0, length]).rotate_x(90.0).rotate_z(90.0).translate([-length / 2.0, 0, base_t - 0.01]);
base + s - cylinder([-length / 2.0 + 8.0, 0, -1], "Z", 1.6, base_t + saddle_h + 2.0) - cylinder([length / 2.0 - 8.0, 0, -1], "Z", 1.6, base_t + saddle_h + 2.0)
