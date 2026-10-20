// Parallel key DIN 6885 form A, 8 x 7 x 40 mm: round ends (r = 4 mm), 0.4 mm chamfer on all long edges, for 22-30 mm shafts
let key_width = 8.0; // [3.0, 20.0] Key width (mm)
let key_height = 7.0; // [3.0, 14.0] Key height (mm)
let key_length = 40.0; // [20.0, 120.0] Key length (mm)
let edge_chamfer = 0.4; // [0.1, 0.8] Edge chamfer (mm)
let half = (key_length - key_width) / 2.0;
let r = key_width / 2.0;
let outline = sketch("XY").move_to(-half, -r).hline(2.0 * half).arc_to(half + r, 0.0, half, r).hline(-2.0 * half).arc_to(-half - r, 0.0, -half, -r).close();
let key = outline.to_face().extrude(key_height);
key.chamfer(min(edge_chamfer, key_height * 0.1), ">Z or <Z")
