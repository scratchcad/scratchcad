// Bullseye fairlead for 8 mm line: 32 mm round 10 mm tall, 9 mm flared bore, 2 x 4.5 mm mounting holes on 24 mm
let d = 32.0; // [24.0, 45.0] Body diameter (mm)
let height = 10.0; // [7.0, 15.0] Height (mm)
let line = 8.0; // [4.0, 12.0] Line diameter (mm)
let p = sketch("XZ").move_to(line / 2.0 + 2.5, 0).hline_to(d / 2.0).line_to(d / 2.0 - 3.0, height).hline_to(line / 2.0 + 2.5).line_to(line / 2.0 + 0.5, height / 2.0).close();
let body = p.face().revolve("Z", 360);
let base = cylinder(d / 2.0 + 6.0, 2.0) & box_centered(d + 14.0, d * 0.6, 10.0);
body + base - cylinder([-(d + 12.0) / 2.0 + 3.0, 0, -1], "Z", 2.25, 4.0) - cylinder([(d + 12.0) / 2.0 - 3.0, 0, -1], "Z", 2.25, 4.0)
