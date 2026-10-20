// Truck bushing cup washer: 25.4 mm OD, 1.5 mm plate with a 3 mm high cup lip 1.2 mm thick and a 9.8 mm hole for a 3/8 inch kingpin
let od = 25.4; // [20.0, 30.0] Washer OD (mm)
let lip = 3.0; // [1.5, 5.0] Cup lip height (mm)
const t = 1.5;
const hole = 9.8;
let w = cylinder([0, 0, 0], "Z", od / 2.0, t + lip) - cylinder([0, 0, t], "Z", od / 2.0 - 1.2, lip + 1.0);
w - cylinder([0, 0, -1.0], "Z", hole / 2.0, t + 2.0)
