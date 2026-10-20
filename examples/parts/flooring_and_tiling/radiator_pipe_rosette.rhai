// Radiator pipe cover rosette: 50 mm split collar 10 mm tall for a 15 mm copper pipe, 15.5 mm bore, 1 mm saw-cut split, hollow underneath with a 3 mm conical wall
let pipe = 15.0; // [8.0, 22.0] Pipe diameter (mm)
let od = 50.0; // [35.0, 65.0] Rosette diameter (mm)
const h = 10.0;
let r = cone(od / 2.0, od / 2.0 - 4.0, h) - cylinder([0, 0, -1.0], "Z", pipe / 2.0 + 0.25, h + 2.0) - cylinder([0, 0, -1.0], "Z", od / 2.0 - 6.0, h - 3.0 + 1.0) + (cylinder([0, 0, 0], "Z", pipe / 2.0 + 2.5, h - 0.01) - cylinder([0, 0, -1.0], "Z", pipe / 2.0 + 0.25, h + 2.0));
let split = box_from_corners([-0.5, 0, -1.0], [0.5, od, h + 1.0]);
r - split
