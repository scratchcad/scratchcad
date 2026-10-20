// Developing tank agitator stick: 8 mm square stick 120 mm long with a 12 mm two-flat drive tip that fits the reel core and a 20 mm knob
let length = 120.0; // [80.0, 160.0] Stick length (mm)
let tip = 12.0; // [8.0, 16.0] Drive tip width (mm)
let s = box_centered(8.0, 8.0, length).translate([0, 0, length / 2.0]);
let drive = box_centered(tip, 4.0, 15.0).translate([0, 0, 7.5]);
let knob = cylinder([0, 0, length - 0.01], "Z", 10.0, 10.0);
let knob = knob.chamfer(2.0, knob.edges(">Z"));
s + drive + knob
