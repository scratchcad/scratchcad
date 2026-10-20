// Wick watering reservoir cap: screws over a bottle neck as a 30 mm cap 15 mm tall, 2 mm walls, with a 6 mm wick port tube 25 mm long and a 3 mm air vent
let neck = 28.0; // [24.0, 38.0] Bottle neck OD (mm)
let wick = 6.0; // [4.0, 10.0] Wick diameter (mm)
const wall = 2.0;
let r = neck / 2.0 + 0.3;
let c = cylinder([0, 0, 0], "Z", r + wall, 15.0) - cylinder([0, 0, -1.0], "Z", r, 14.0);
let port = cylinder([0, 0, 14.99], "Z", wick / 2.0 + 1.5, 25.0) - cylinder([0, 0, 13.0], "Z", wick / 2.0, 30.0);
c + port - cylinder([0, 0, 0], "Z", wick / 2.0, 20.0) - cylinder([r * 0.6, 0, 12.0], "Z", 1.5, 5.0)
