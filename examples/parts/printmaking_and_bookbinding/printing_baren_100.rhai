// Block printing baren: 100 mm disc 8 mm thick with a 2 mm domed-down chamfer on the rubbing face and a 30 mm knob handle 35 mm tall
let dia = 100.0; // [70.0, 140.0] Baren diameter (mm)
let knob = 30.0; // [20.0, 40.0] Knob diameter (mm)
const t = 8.0;
let disc = cylinder([0, 0, 0], "Z", dia / 2.0, t);
let disc = disc.chamfer(2.0, disc.edges("<Z"));
let stem = cylinder([0, 0, t - 0.01], "Z", knob / 3.0, 20.0);
let ball = sphere([0, 0, t + 20.0 + knob / 2.0 - 3.0], knob / 2.0);
disc + stem + ball
