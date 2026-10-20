// Picnic table parasol hole reducer: 50 mm hole insert 25 mm deep with a 60 mm top flange 3 mm, reducing to a 38 mm pole bore
let hole = 50.0; // [40.0, 60.0] Table hole diameter (mm)
let pole = 38.0; // [25.0, 45.0] Parasol pole diameter (mm)
let r = hole / 2.0 - 0.3;
let ins = cylinder([0, 0, -25.0], "Z", r, 25.01) + cylinder([0, 0, 0], "Z", r + 5.0, 3.0);
ins - cylinder([0, 0, -26.0], "Z", pole / 2.0 + 0.3, 30.0)
