// Rubber door stop wedge: 120 mm long, 40 mm wide, 3 to 30 mm tall, four grip grooves and an 8 mm hanging hole
let len = 120.0; // [80.0, 180.0] Length (mm)
let h = 30.0; // [15.0, 50.0] Height (mm)
let w = 40.0; // [25.0, 60.0] Width (mm)
let wedge = polygon([[0, 0, 0], [len, 0, 0], [len, 0, h], [0, 0, 3.0]]).to_face().extrude([0, w, 0]);
for f in [0.33, 0.5, 0.67] { let x = len * f; wedge -= cylinder([x, -1, 3.0 + (h - 3.0) * x / len], "Y", 1.5, w + 2.0); }
wedge - cylinder([len - 15.0, -1, h * 0.45], "Y", 4.0, w + 2.0)
