// Barrow wheel bearing dust shield: 47 mm press-in shield for a 6204 bearing housing, 3 mm thick, with a 20.5 mm shaft hole and a 3 mm lip 2 mm tall around the hole
let housing = 47.0; // [35.0, 62.0] Bearing housing bore (mm)
let shaft = 20.5; // [12.0, 25.0] Shaft hole (mm)
const t = 3.0;
let s = cylinder([0, 0, 0], "Z", housing / 2.0 + 0.1, t) + cylinder([0, 0, t - 0.01], "Z", shaft / 2.0 + 3.0, 2.0);
s - cylinder([0, 0, -1.0], "Z", shaft / 2.0, t + 4.0)
