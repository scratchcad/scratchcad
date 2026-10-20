// Turned bun foot: 100 mm diameter, 75 mm tall, 30 mm collar, 10 mm hanger bolt hole 25 mm deep
let d = 100.0; // [60.0, 140.0] Foot diameter (mm)
let height = 75.0; // [50.0, 100.0] Height (mm)
let p = sketch("XZ").move_to(0, 0).hline_to(d * 0.3).line_to(d / 2.0, height * 0.35).line_to(d * 0.42, height * 0.7).line_to(d * 0.3, height * 0.8).vline_to(height).hline_to(0).close();
let foot = p.face().revolve("Z", 360);
foot - cylinder([0, 0, height - 25.0], "Z", 4.0, 26.0)
