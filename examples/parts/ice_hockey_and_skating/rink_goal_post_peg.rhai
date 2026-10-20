// Ice rink goal post peg: 10 mm steel-style peg 60 mm long with a 25 mm flange 5 mm and a 3 mm rubber-sleeve groove, sits in a floor anchor
let peg = 10.0; // [8.0, 16.0] Peg diameter (mm)
let length = 60.0; // [40.0, 100.0] Peg length (mm)
let p = cylinder([0, 0, -length], "Z", peg / 2.0, length + 0.01) + cylinder([0, 0, 0], "Z", 12.5, 5.0);
let groove = cylinder([0, 0, -length + 10.0], "Z", peg / 2.0 + 1.0, 3.0) - cylinder([0, 0, -length + 9.0], "Z", peg / 2.0 - 1.0, 5.0);
let p = p - groove;
p.chamfer(1.0, p.edges("<Z"))
