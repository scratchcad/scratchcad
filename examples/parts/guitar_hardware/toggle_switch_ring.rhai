// Les Paul toggle switch washer ring: 38 mm round ring 1.5 mm thick with a 12.5 mm centre hole, raised 1 mm lettering band 4 mm wide at the rim and a 3 mm anti-rotation tab hole
let dia = 38.0; // [30.0, 50.0] Ring diameter (mm)
let hole = 12.5; // [9.5, 13.0] Switch bushing hole (mm)
const t = 1.5;
let r = cylinder([0, 0, 0], "Z", dia / 2.0, t);
let band = cylinder([0, 0, t - 0.01], "Z", dia / 2.0, 1.0) - cylinder([0, 0, t - 1.0], "Z", dia / 2.0 - 4.0, 3.0);
r + band - cylinder([0, 0, -1.0], "Z", hole / 2.0, t + 3.0) - cylinder([0, hole / 2.0 + 3.0, -1.0], "Z", 1.5, t + 3.0)
