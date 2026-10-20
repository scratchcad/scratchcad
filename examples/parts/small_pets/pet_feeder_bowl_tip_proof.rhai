// Tip-proof small-pet food bowl: 100 mm base tapering to an 80 mm rim 35 mm tall, 25 mm deep bowl with a 3 mm wall at the rim, heavy flat bottom 10 mm and an inward 3 mm lip
let base = 100.0; // [90.0, 150.0] Base diameter (mm)
let height = 35.0; // [25.0, 50.0] Bowl height (mm)
const rim = 80.0;
let b = cone(base / 2.0, rim / 2.0, height);
let cavity = cone(rim / 2.0 - 8.0, rim / 2.0 - 3.0, height - 10.0 + 0.01).translate([0, 0, 10.0]);
let lip = cylinder([0, 0, height - 3.0], "Z", rim / 2.0 - 2.99, 3.0) - cylinder([0, 0, height - 4.0], "Z", rim / 2.0 - 6.0, 5.0);
b - cavity + lip
