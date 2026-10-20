// Piano white key top (C key): 150 mm long, 23.5 mm front, 13.7 mm back neck, 2 mm cladding, rounded front
let length = 150.0; // [130.0, 160.0] Key length (mm)
let front_w = 23.5; // [22.0, 24.0] Front width (mm)
let neck_w = 13.7; // [12.0, 15.0] Neck width (mm)
let t = 2.0; // [1.5, 3.0] Thickness (mm)
let front_l = 50.0; // [45.0, 55.0] Front head length (mm)
let top = polygon([[0, 0], [front_w, 0], [front_w, front_l], [neck_w, front_l], [neck_w, length], [0, length]]).to_face().extrude([0, 0, t]);
let face = box_from_corners([0, -t, -10.0], [front_w, 0.01, t]);
let k = top + face;
k.fillet(0.8, k.edges("|X and <Y"))
