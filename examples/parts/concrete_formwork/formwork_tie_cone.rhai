// Formwork tie cone spacer: 22 mm to 30 mm cone 25 mm long on a 15 mm tie rod, 15.5 mm bore, so the tie hole can be plugged after stripping
let small = 22.0; // [16.0, 26.0] Small end diameter (mm)
let length = 25.0; // [15.0, 40.0] Cone length (mm)
let rod = 15.5; // [10.5, 16.0] Tie rod bore (mm)
cone(small / 2.0 + 4.0, small / 2.0, length) - cylinder([0, 0, -1.0], "Z", rod / 2.0, length + 2.0)
