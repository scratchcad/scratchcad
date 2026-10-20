// Stove thermometer magnet mount: 54 mm disc 8 mm thick for a 51 mm dial with a 30 x 5 mm magnet pocket underneath and a 51 mm press-fit recess 2 mm deep on top
let dia = 52.0; // [45.0, 70.0] Mount diameter (mm)
let magnet = 30.0; // [15.0, 35.0] Magnet diameter (mm)
const t = 8.0;
let m = cylinder([0, 0, 0], "Z", dia / 2.0 + 2.0, t);
m - cylinder([0, 0, -1.0], "Z", magnet / 2.0 + 0.2, 6.0) - cylinder([0, 0, t - 2.0], "Z", dia / 2.0 - 0.5, 3.0)
