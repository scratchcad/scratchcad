// Nostepinne yarn winder: 250 mm turned stick, 25 mm handle tapering to a 12 mm winding shaft with a 6 mm notch groove
let length = 250.0; // [180.0, 320.0] Length (mm)
let handle = 25.0; // [18.0, 32.0] Handle diameter (mm)
let shaft = 12.0; // [8.0, 18.0] Shaft diameter at the tip (mm)
let p = sketch("XZ").move_to(0, 0).hline_to(handle / 2.0 - 2.0).line_to(handle / 2.0, 6.0).vline_to(90.0).line_to(handle / 2.0 - 3.0, 100.0).line_to(shaft / 2.0 + 3.0, 110.0).line_to(shaft / 2.0, length - 5.0).line_to(shaft / 2.0 - 3.0, length).hline_to(0).close();
let s = p.face().revolve("Z", 360);
s - (cylinder([0, 0, length - 20.0], "Z", shaft, 2.0) - cylinder([0, 0, length - 21.0], "Z", shaft / 2.0 - 1.0, 4.0))
