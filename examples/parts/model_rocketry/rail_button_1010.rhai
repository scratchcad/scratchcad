// 1010 rail button: 11.2 mm head 2.9 mm, 7.7 mm waist 3.6 mm, 9.5 mm base flange 1.5 mm, #8 screw 4.4 mm
let head = 11.2; // [9.0, 16.0] Head diameter (mm)
let waist = 7.7; // [6.0, 10.0] Waist diameter (mm)
let base = 9.5; // [8.0, 14.0] Base diameter (mm)
let b = cylinder(base / 2.0, 1.5) + cylinder([0, 0, 1.49], "Z", waist / 2.0, 3.62) + cylinder([0, 0, 5.1], "Z", head / 2.0, 2.9);
let bb = b.chamfer(0.5, b.edges("%CIRCLE").filter(|e| e.radius() > head / 2.0 - 0.01));
bb - cylinder([0, 0, -1], "Z", 2.2, 10.0) - cone(2.2, 4.0, 1.81).translate([0, 0, 6.2])
