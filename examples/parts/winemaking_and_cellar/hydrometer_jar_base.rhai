// Hydrometer test jar stand: 90 mm weighted base 10 mm thick with a 42 mm socket 15 mm deep for a 40 mm jar, 3 mm walls and a drip channel round the socket
let jar = 42.0; // [30.0, 60.0] Jar foot diameter (mm)
let base_d = 90.0; // [70.0, 120.0] Base diameter (mm)
const t = 10.0;
let b = cylinder([0, 0, 0], "Z", base_d / 2.0, t);
let b = b.chamfer(2.0, b.edges(">Z"));
let ring = cylinder([0, 0, t - 0.01], "Z", jar / 2.0 + 3.0, 15.0);
let channel = cylinder([0, 0, t - 2.0], "Z", jar / 2.0 + 8.0, 3.0) - cylinder([0, 0, t - 3.0], "Z", jar / 2.0 + 3.0, 5.0);
b + ring - cylinder([0, 0, 2.0], "Z", jar / 2.0, 30.0) - channel
