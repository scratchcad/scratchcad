// Fireplace tool stand base: 200 mm disc 10 mm thick with a 2 mm chamfer, central 25.4 mm socket boss 40 mm tall bored 19.2 mm for a 3/4 inch post with an M6 set screw
let dia = 200.0; // [150.0, 260.0] Base diameter (mm)
let post = 19.2; // [16.0, 25.5] Post bore (mm)
const t = 10.0;
let disc = cylinder([0, 0, 0], "Z", dia / 2.0, t);
let disc = disc.chamfer(2.0, disc.edges(">Z"));
let boss = cylinder([0, 0, t - 0.01], "Z", post / 2.0 + 6.0, 40.0);
disc + boss - cylinder([0, 0, 3.0], "Z", post / 2.0, 50.0) - cylinder([0, 0, t + 30.0], "X", 2.5, post / 2.0 + 8.0)
