// Mixing desk pot knob: 14 mm skirted knob 16 mm tall, 18 mm skirt 2 mm thick with a white-line pointer slot, 6 mm knurled-shaft bore (5.8 mm) 10 mm deep
let dia = 14.0; // [10.0, 22.0] Knob diameter (mm)
let height = 16.0; // [10.0, 24.0] Knob height (mm)
let skirt = 18.0; // [14.0, 28.0] Skirt diameter (mm)
let k = cone(dia / 2.0, dia / 2.0 - 1.0, height) + cylinder([0, 0, 0], "Z", skirt / 2.0, 2.0);
let line = box_from_corners([-0.5, 0, height - 0.6], [0.5, dia / 2.0 + 1.0, height + 1.0]) + box_from_corners([-0.5, dia / 2.0 - 1.5, -1.0], [0.5, skirt / 2.0 + 1.0, 2.0 + 1.0]) - cylinder([0, 0, -2.0], "Z", dia / 2.0 - 1.0, height + 4.0);
k - line - cylinder([0, 0, -1.0], "Z", 2.9, 11.0)
