// Tub spout diverter pull knob: 20 mm ball on a 12 mm neck 18 mm long, blind 4 mm bore for the diverter rod and an M3 grub screw hole
let ball_d = 20.0; // [14.0, 28.0] Ball diameter (mm)
let neck_d = 12.0; // [8.0, 16.0] Neck diameter (mm)
let neck_l = 18.0; // [10.0, 30.0] Neck length (mm)
let rod_d = 4.0; // [3.0, 6.0] Diverter rod diameter (mm)
let neck = cylinder(neck_d / 2.0, neck_l + 2.0);
let n = neck.chamfer(0.8, neck.edges("<Z"));
let ball = sphere([0, 0, neck_l + ball_d * 0.4], ball_d / 2.0);
n + ball - cylinder([0, 0, -1], "Z", rod_d / 2.0 + 0.1, neck_l + 1.0) - cylinder([0, 0, neck_l * 0.4], "X", 1.25, neck_d)
