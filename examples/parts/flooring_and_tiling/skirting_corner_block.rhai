// Skirting board outside corner block: 30 x 30 mm post 120 mm tall that the two skirting boards butt into, 3 mm chamfered top, 1 mm plinth step and two 4 mm screw holes from the back corner
let size = 30.0; // [22.0, 40.0] Block size (mm)
let height = 120.0; // [70.0, 170.0] Skirting height (mm)
let b = box_from_corners([0, 0, 0], [size, size, height]);
let b = b.chamfer(3.0, b.edges(">Z"));
let plinth = box_from_corners([-1.0, -1.0, 0], [size + 1.0, size + 1.0, 20.0]);
let a = cylinder([0, 0, 0], "X", 2.0, size * 2.0).rotate_z(45.0).translate([-5.0, -5.0, height * 0.3]) + cylinder([0, 0, 0], "X", 2.0, size * 2.0).rotate_z(45.0).translate([-5.0, -5.0, height * 0.75]);
b + plinth - a
