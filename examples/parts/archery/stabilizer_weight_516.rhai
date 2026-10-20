// Bow stabilizer end weight: 25 mm dia 30 mm long with a 5/16-24 tapped hole (6.9 mm tap drill) 12 mm deep, a 7.9 mm threaded stud 10 mm long and two 2 mm grip grooves
let od = 25.0; // [18.0, 32.0] Weight diameter (mm)
let length = 30.0; // [15.0, 50.0] Weight length (mm)
const tap = 6.9;
let w = cylinder([0, 0, 0], "Z", od / 2.0, length);
let w = w.chamfer(1.0, w.edges("%CIRCLE"));
let grooves = [];
for z in [length / 3.0, 2.0 * length / 3.0] { grooves.push(cylinder([0, 0, z - 1.0], "Z", od / 2.0 + 1.0, 2.0) - cylinder([0, 0, z - 2.0], "Z", od / 2.0 - 0.8, 4.0)); }
let stud = cylinder([0, 0, length - 0.01], "Z", 3.95, 10.0);
w - fuse_all(grooves) - cylinder([0, 0, -1.0], "Z", tap / 2.0, 13.0) + stud
