// Steam kettle lid knob: phenolic mushroom knob 45 mm across, 32 mm tall on a 22 mm neck, with a 5 mm M6 tap hole 14 mm deep and a 1.5 mm chamfer on the crown
let dia = 45.0; // [35.0, 60.0] Knob diameter (mm)
let height = 32.0; // [25.0, 45.0] Knob height (mm)
let neck_d = 22.0; // [16.0, 28.0] Neck diameter (mm)
const crown = 12.0;
let r = dia / 2.0;
let rn = neck_d / 2.0;
let knob = face(polygon([[0, 0, 0], [rn + 2.0, 0, 0], [rn, 0, 2.0], [rn, 0, height - crown - 4.0], [r, 0, height - crown], [r, 0, height - 3.0], [r - 3.0, 0, height], [0, 0, height]])).revolve("Z", 360);
knob - cylinder([0, 0, -1.0], "Z", 2.5, 15.0)
