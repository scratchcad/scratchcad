// Spinning reel handle knob: 22 x 12 mm T-bar grip 18 mm tall, 4 mm axle bore, 2 bearing seats 7 mm
let length = 22.0; // [15.0, 35.0] Knob length (mm)
let width = 12.0; // [8.0, 18.0] Knob width (mm)
let height = 18.0; // [12.0, 25.0] Height (mm)
let k = box_centered(length, width, height).translate([0, 0, height / 2.0]);
let kk = k.fillet(width / 2.0 - 0.5, k.edges("|Z"));
let top = kk.fillet(3.0, kk.edges(">Z or <Z"));
top - cylinder([0, 0, -1], "Z", 2.0, height + 2.0) - cylinder([0, 0, -1], "Z", 3.5, 4.0) - cylinder([0, 0, height - 3.0], "Z", 3.5, 4.0)
