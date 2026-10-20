// No. 6 rubber stopper, one hole: 32 mm top, 26 mm bottom, 25 mm tall, 7 mm hole for glass tubing
let top = 32.0; // [15.0, 60.0] Top diameter (mm)
let bottom = 26.0; // [12.0, 50.0] Bottom diameter (mm)
let hole = 7.0; // [0.0, 12.0] Hole diameter (mm)
cone(bottom / 2.0, top / 2.0, 25.0).chamfer(0.8, "%CIRCLE") - cylinder([0, 0, -1], "Z", hole / 2.0, 27.0)
