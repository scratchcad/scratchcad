// Trellis wall spacer: 25 mm stand-off 30 mm long holding trellis off the wall, 20 mm OD with a 5.5 mm screw bore, a 6 mm counterbore and a 40 mm grip washer face
let standoff = 30.0; // [15.0, 60.0] Stand-off length (mm)
let od = 20.0; // [15.0, 30.0] Spacer diameter (mm)
let s = cylinder([0, 0, 0], "Z", od / 2.0, standoff) + cylinder([0, 0, standoff - 0.01], "Z", 20.0, 3.0);
s - cylinder([0, 0, -1.0], "Z", 2.75, standoff + 5.0) - cylinder([0, 0, standoff - 3.0], "Z", 5.0, 7.0)
