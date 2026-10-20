// Picture rail hook: hooks over a 20 mm picture rail moulding with a 12 mm drop, 15 mm wide, 3 mm thick, with a 6 mm cord eye 70 mm below the rail lip
let rail = 20.0; // [12.0, 30.0] Rail moulding depth (mm)
let drop = 70.0; // [40.0, 120.0] Drop to cord eye (mm)
const t = 3.0;
const w = 15.0;
let top = box_from_corners([0, 0, 0], [rail + 2.0 * t, w, t]);
let lip = box_from_corners([0, 0, -12.0], [t, w, 0.01]);
let stem = box_from_corners([rail + t, 0, -drop], [rail + 2.0 * t, w, 0.01]);
let eye = cylinder([rail + t - 0.01, w / 2.0, -drop + 6.0], "X", 6.0, t) - cylinder([rail + t - 1.0, w / 2.0, -drop + 6.0], "X", 3.0, t + 2.0);
let eye_block = box_from_corners([rail + t, w / 2.0 - 6.0, -drop], [rail + 2.0 * t, w / 2.0 + 6.0, -drop + 6.0]);
top + lip + stem + eye_block + eye - cylinder([rail + t - 1.0, w / 2.0, -drop + 6.0], "X", 3.0, t + 2.0)
