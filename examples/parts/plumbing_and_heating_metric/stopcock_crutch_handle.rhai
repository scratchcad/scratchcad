// Stopcock crutch head handle (BS 1010 15/22 mm stop valve): 50 mm T-bar 9 mm deep, 16 mm hub 18 mm tall, 6.5 mm square spindle socket 12 mm deep, 4 mm top screw hole
let span = 50.0; // [35.0, 70.0] Crutch span (mm)
let bar_h = 9.0; // [6.0, 14.0] Crutch depth (mm)
let bar_w = 8.0; // [5.0, 12.0] Crutch thickness (mm)
let hub_d = 16.0; // [12.0, 22.0] Hub diameter (mm)
let hub_h = 18.0; // [12.0, 26.0] Hub height (mm)
let square = 6.5; // [5.0, 9.0] Spindle square (mm)
let hd = max(hub_d, square * 1.42 + 3.0);
let hub = cylinder(hd / 2.0, hub_h);
let bar = box_centered(span, bar_w, bar_h).translate([0, 0, hub_h - bar_h / 2.0]);
let bar = bar.fillet(min(bar_w, bar_h) * 0.45, bar.edges("|Y"));
let body = hub + bar;
body - box_centered(square, square, 2.0 * min(12.0, hub_h - 4.0)) - cylinder([0, 0, hub_h - 5.0], "Z", 2.0, 10.0)
