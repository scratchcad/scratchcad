// 250 ml Erlenmeyer flask: 85 mm base, 143 mm tall, conical body to a 34 mm neck 22 mm long, 1.6 mm wall, beaded rim
let base = 85.0; // [50.0, 130.0] Base diameter (mm)
let h = 143.0; // [90.0, 220.0] Height (mm)
let rb = base / 2.0;
let zn = h - 25.0;
let p = [[0, 0, 0], [rb - 3.0, 0, 0], [rb, 0, 3.0], [17.0, 0, zn], [17.0, 0, h - 3.0], [18.5, 0, h - 3.0], [18.5, 0, h], [15.4, 0, h], [15.4, 0, zn + 0.8], [rb - 1.64, 0, 4.6], [rb - 3.5, 0, 1.6], [0, 0, 1.6]];
polygon(p).to_face().revolve("Z", 360)
