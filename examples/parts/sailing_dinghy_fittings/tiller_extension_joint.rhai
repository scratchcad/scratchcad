// Tiller extension universal joint body: 20 mm tube socket 30 mm deep, rubber-joint flange 30 mm with 4 x 4 mm holes
let tube = 20.0; // [16.0, 28.0] Extension tube OD (mm)
let depth = 30.0; // [20.0, 40.0] Socket depth (mm)
let flange = 30.0; // [24.0, 45.0] Flange diameter (mm)
let socket = cylinder(tube / 2.0 + 2.5, depth) - cylinder([0, 0, 3.0], "Z", tube / 2.0, depth);
let f = cylinder([0, 0, -4.0], "Z", flange / 2.0, 4.01);
let holes = [];
for k in 0..4 { let a = (k.to_float() * 90.0 + 45.0) * PI() / 180.0; holes.push(cylinder([flange * 0.35 * a.cos(), flange * 0.35 * a.sin(), -5.0], "Z", 2.0, 6.0)); }
socket + f - compound(holes) - cylinder([-tube, 0, depth - 10.0], "X", 2.0, tube * 2.0)
