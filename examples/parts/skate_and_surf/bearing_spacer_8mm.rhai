// Skateboard bearing spacer: 10 mm OD, 8.2 mm ID for an 8 mm axle, 10.4 mm long, with 0.3 mm end chamfers
let od = 10.0; // [9.5, 11.0] Spacer OD (mm)
let length = 10.4; // [9.0, 12.0] Spacer length (mm)
const id = 8.2;
let s = cylinder([0, 0, 0], "Z", od / 2.0, length) - cylinder([0, 0, -1.0], "Z", id / 2.0, length + 2.0);
s.chamfer(0.3, s.edges("%CIRCLE"))
