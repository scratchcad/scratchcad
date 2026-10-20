// Scotch yoke slider: 70 mm frame, 12 mm slot for a 10 mm crank pin, 30 mm stroke, 8 mm rods both ends
let stroke = 30.0; // [10.0, 60.0] Stroke (mm)
let pin = 10.0; // [5.0, 15.0] Crank pin (mm)
let thickness = 8.0; // [5.0, 12.0] Thickness (mm)
let rod_d = 8.0; // [5.0, 12.0] Rod diameter (mm)
let h = stroke + pin + 12.0;
let frame = box_centered(pin + 12.0, h, thickness) - box_centered(pin + 0.4, stroke + pin + 0.4, thickness + 2.0);
let rods = cylinder([-(pin + 12.0) / 2.0 - 40.0, 0, 0], "X", rod_d / 2.0, 40.01) + cylinder([(pin + 12.0) / 2.0 - 0.01, 0, 0], "X", rod_d / 2.0, 40.0);
frame + rods
