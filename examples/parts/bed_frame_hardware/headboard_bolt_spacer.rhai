// Headboard bolt spacer: 30 mm round spacer 25 mm long with an 8.5 mm bore for an M8 headboard bolt and a 2 mm bevel at the wall end
let length = 25.0; // [10.0, 60.0] Spacer length (mm)
let od = 30.0; // [20.0, 40.0] Spacer diameter (mm)
let s = cylinder([0, 0, 0], "Z", od / 2.0, length);
let s = s.chamfer(2.0, s.edges("<Z"));
s - cylinder([0, 0, -1.0], "Z", 4.25, length + 2.0)
