// Pool cue ferrule: 13 mm OD x 25 mm, 8 mm tenon bore 20 mm deep, 0.5 mm tip seat chamfer
let od = 13.0; // [11.0, 14.0] Ferrule diameter (mm)
let length = 25.0; // [15.0, 30.0] Length (mm)
let tenon = 8.0; // [6.0, 10.0] Tenon bore (mm)
let f = cylinder(od / 2.0, length);
let ff = f.chamfer(0.5, f.edges(">Z"));
ff - cylinder([0, 0, -1], "Z", tenon / 2.0, 21.0)
