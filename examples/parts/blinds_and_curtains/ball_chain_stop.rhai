// Ball chain stop for #10 (4.5 mm) bead chain: 10 x 8 mm body, 4.6 mm bead channel with 1.6 mm link slot
let bead = 4.5; // [3.2, 6.0] Bead diameter (mm)
let length = 10.0; // [6.0, 15.0] Length (mm)
let body = cylinder([0, 0, 0], "Z", 4.0, length);
let b = body.chamfer(1.0, body.edges("%CIRCLE"));
b - cylinder([0, 0, -1], "Z", bead / 2.0 + 0.1, length + 2.0) - box_from_corners([-0.8, 0, -1], [0.8, 5.0, length + 1.0])
