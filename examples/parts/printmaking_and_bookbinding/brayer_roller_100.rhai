// Brayer roller for block printing: 100 mm wide, 38 mm diameter with 1 mm edge chamfers, 8 mm axle bore and 22 mm x 7 mm 608 bearing recesses at both ends
let width = 100.0; // [50.0, 150.0] Roller width (mm)
let od = 38.0; // [30.0, 50.0] Roller diameter (mm)
let roller = cylinder([0, 0, 0], "Z", od / 2.0, width);
let roller = roller.chamfer(1.0, roller.edges("%CIRCLE"));
let bore = cylinder([0, 0, -1.0], "Z", 4.1, width + 2.0);
let seats = cylinder([0, 0, -1.0], "Z", 11.0, 8.0) + cylinder([0, 0, width - 7.0], "Z", 11.0, 8.0);
roller - bore - seats
