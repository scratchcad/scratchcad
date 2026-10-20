// Molecular model hydrogen atom: 15 mm ball with a single 4.2 mm peg hole 6 mm deep
let ball = 15.0; // [10.0, 25.0] Atom diameter (mm)
let hole = 4.2; // [3.0, 6.0] Peg hole (mm)
let depth = 6.0; // [4.0, 10.0] Hole depth (mm)
sphere(ball / 2.0) - cylinder([0, 0, ball / 2.0 - depth], "Z", hole / 2.0, depth + 2.0)
