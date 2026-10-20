// Speaker grille fixing peg: 6 mm ball-end peg 12 mm long with a 10 mm flange, pressing into an 8 mm grommet cup with a 7 mm collar 10 mm deep (2 bodies: peg and cup)
let peg = 6.0; // [4.0, 8.0] Peg diameter (mm)
let length = 12.0; // [8.0, 18.0] Peg length (mm)
let p = cylinder([0, 0, 0], "Z", 5.0, 1.5) + cylinder([0, 0, 1.49], "Z", peg / 2.0 - 1.0, length - peg / 2.0) + sphere([0, 0, length - peg / 2.0 + 1.5], peg / 2.0);
let cup = (cylinder([20.0, 0, 0], "Z", 4.0, 10.0) + cylinder([20.0, 0, 9.99], "Z", 6.0, 1.5)) - cylinder([20.0, 0, -1.0], "Z", peg / 2.0 - 0.3, 13.0);
compound([p, cup])
