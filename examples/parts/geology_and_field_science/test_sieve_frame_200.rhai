// Laboratory test sieve frame: 200 mm ID, 50 mm overall, 2 mm wall, a 10 mm nesting skirt that fits inside the sieve below and a 5 mm mesh seat ledge where the skirt meets the body
let id = 200.0; // [100.0, 300.0] Sieve inside diameter (mm)
let height = 50.0; // [25.0, 75.0] Frame height (mm)
const wall = 2.0;
const skirt_h = 10.0;
let r = id / 2.0;
let body = cylinder([0, 0, skirt_h], "Z", r + wall, height - skirt_h) - cylinder([0, 0, skirt_h - 1.0], "Z", r, height);
let skirt = cylinder([0, 0, 0], "Z", r - 0.25, skirt_h + 0.01) - cylinder([0, 0, -1.0], "Z", r - 0.25 - wall, skirt_h + 2.0);
let ledge = cylinder([0, 0, skirt_h - 0.01], "Z", r + 0.01, 3.0) - cylinder([0, 0, skirt_h - 1.0], "Z", r - 5.0, 5.0);
body + skirt + ledge
