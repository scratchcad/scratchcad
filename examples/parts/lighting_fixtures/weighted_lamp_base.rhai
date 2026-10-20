// Table lamp base: 150 mm stepped round base 30 mm tall, 10 mm (3/8 in) threaded rod bore, cord channel 6 mm, felt recess
let diameter = 150.0; // [100.0, 220.0] Base diameter (mm)
let height = 30.0; // [20.0, 45.0] Base height (mm)
let rod = 10.0; // [8.0, 13.0] Rod bore (mm)
let p = sketch("XZ").move_to(0, 0).hline_to(diameter / 2.0).vline_to(height * 0.35).hline_to(diameter / 2.0 - 10.0).line_to(diameter * 0.3, height * 0.7).hline_to(diameter * 0.18).vline_to(height).hline_to(0).close();
let b = p.face().revolve("Z", 360);
b - cylinder([0, 0, -1], "Z", rod / 2.0, height + 2.0) - cylinder([0, 0, -1], "Z", diameter / 2.0 - 5.0, 3.0) - box_from_corners([-3.0, 0, 1.99], [3.0, diameter, 8.0])
