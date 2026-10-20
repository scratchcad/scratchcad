// Convection oven door hinge bushing: flanged PTFE-style bush for a 10 mm hinge pin, 14 mm OD, 15 mm long, 20 mm flange 2 mm thick with an anti-rotation flat
let pin_d = 10.0; // [6.0, 12.0] Hinge pin diameter (mm)
let length = 15.0; // [8.0, 25.0] Bush length (mm)
let flange_d = 20.0; // [18.0, 26.0] Flange diameter (mm)
const flange_t = 2.0;
let od = pin_d + 4.0;
let bush = cylinder([0, 0, 0], "Z", flange_d / 2.0, flange_t) + cylinder([0, 0, flange_t - 0.01], "Z", od / 2.0, length - flange_t + 0.01);
let flat = max(flange_d / 2.0 - 2.0, od / 2.0 + 0.5);
bush = bush - box_from_corners([flat, -flange_d, -1.0], [flange_d, flange_d, flange_t + 0.001]);
bush = bush - cylinder([0, 0, -1.0], "Z", pin_d / 2.0 + 0.05, length + 2.0);
bush.chamfer(0.5, bush.edges("%CIRCLE and >Z"))
