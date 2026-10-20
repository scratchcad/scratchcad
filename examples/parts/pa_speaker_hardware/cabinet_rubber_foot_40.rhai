// Speaker cabinet foot: 40 mm round foot 15 mm tall tapering to 34 mm, 1.5 mm chamfered base edge, 4.5 mm screw hole with a 9 mm counterbore 8 mm deep and a steel washer seat 12 x 1 mm
let dia = 40.0; // [30.0, 60.0] Foot diameter (mm)
let height = 15.0; // [10.0, 25.0] Foot height (mm)
let f = cone(dia / 2.0 - 3.0, dia / 2.0, height);
let f = f.chamfer(1.5, f.edges("<Z"));
f - cylinder([0, 0, -1.0], "Z", 2.25, height + 2.0) - cylinder([0, 0, -1.0], "Z", 4.5, 9.0) - cylinder([0, 0, 7.99], "Z", 6.0, 1.0)
