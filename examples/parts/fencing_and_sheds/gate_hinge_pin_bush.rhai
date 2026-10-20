// Gate hinge pin bush: nylon top-hat bush for a 16 mm hook-and-band pin, 20 mm OD 30 mm long with a 28 mm x 3 mm thrust collar and a 1 mm grease groove
let pin = 16.0; // [12.0, 22.0] Hinge pin diameter (mm)
let length = 30.0; // [15.0, 45.0] Bush length (mm)
let b = cylinder([0, 0, 0], "Z", pin / 2.0 + 2.0, length) + cylinder([0, 0, length - 0.01], "Z", pin / 2.0 + 6.0, 3.0);
let groove = cylinder([0, 0, length / 2.0 - 0.5], "Z", pin / 2.0 + 0.5, 1.0);
b - cylinder([0, 0, -1.0], "Z", pin / 2.0 + 0.15, length + 5.0) - groove
