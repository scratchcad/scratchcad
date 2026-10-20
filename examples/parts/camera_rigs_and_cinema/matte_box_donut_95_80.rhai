// Matte box lens donut from a 95 mm back opening to an 80 mm lens front: 97 mm flange 2 mm thick, 94.6 mm body 10 mm deep, 80 mm bore with a 78.4 mm sealing lip 1.5 mm thick at the front and a 1 mm lead-in chamfer
let opening_d = 95.0; // [85.0, 114.0] Matte box opening (mm)
let lens_d = 80.0; // [50.0, 80.0] Lens front diameter (mm)
let depth = 10.0; // [6.0, 16.0] Donut depth (mm)
const flange_t = 2.0;
let ro = opening_d / 2.0 - 0.2;
let rf = opening_d / 2.0 + 1.0;
let rb = lens_d / 2.0;
let rl = rb - 0.8;
let h = depth + flange_t;
let profile = polygon([
    [rl, 0, 0], [rf, 0, 0], [rf, 0, flange_t], [ro, 0, flange_t], [ro, 0, h - 1.0], [ro - 1.0, 0, h],
    [rb + 1.0, 0, h], [rb, 0, h - 1.0], [rb, 0, 1.5], [rl, 0, 1.5]]);
face(profile).revolve("Z", 360.0)
