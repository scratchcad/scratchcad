// Bowstring peep sight: 12 mm disc 6 mm thick with a 3/16 inch (4.76 mm) aperture, 1.2 mm string groove round the rim and a 15 degree chamfered eye side
let od = 12.0; // [10.0, 16.0] Peep diameter (mm)
let aperture = 4.76; // [3.0, 6.4] Aperture diameter (mm)
const t = 6.0;
let disc = cylinder([0, 0, 0], "Y", od / 2.0, t);
let groove = cylinder([0, t / 2.0 - 0.6, 0], "Y", od / 2.0 + 1.0, 1.2) - cylinder([0, t / 2.0 - 1.0, 0], "Y", od / 2.0 - 1.0, 2.0);
let hole = cylinder([0, -1.0, 0], "Y", aperture / 2.0, t + 2.0);
let flare = cone(aperture / 2.0, aperture / 2.0 + 1.5, 2.0).rotate_x(-90.0).translate([0, t - 1.99, 0]);
disc - groove - hole - flare
