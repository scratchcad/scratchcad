// Recessed downlight trim ring: 95 mm cut-out, 110 mm face 5 mm, 92 mm collar 12 mm, 2 spring clip slots
let cutout = 95.0; // [60.0, 150.0] Ceiling cut-out (mm)
let face = 110.0; // [75.0, 170.0] Face diameter (mm)
let collar_h = 12.0; // [8.0, 20.0] Collar height (mm)
let p = sketch("XZ").move_to(cutout / 2.0 - 8.0, 0).hline_to(face / 2.0).line_to(face / 2.0 - 4.0, 5.0).hline_to(cutout / 2.0 - 2.5).vline_to(5.0 + collar_h).hline_to(cutout / 2.0 - 4.0).vline_to(3.0).hline_to(cutout / 2.0 - 8.0).close();
let ring = p.face().revolve("Z", 360);
ring - box_centered(10.0, face, 10.0).translate([0, 0, 5.0 + collar_h / 2.0 + 3.0]) 
