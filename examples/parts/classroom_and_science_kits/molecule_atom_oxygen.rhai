// Molecular model oxygen atom: 23 mm ball with 2 peg holes 4.2 mm at 104.5 degrees, 8 mm deep
let ball = 23.0; // [15.0, 30.0] Atom diameter (mm)
let hole = 4.2; // [3.0, 6.0] Peg hole (mm)
let angle = 104.5; // [90.0, 180.0] Bond angle (degrees)
let depth = 8.0; // [5.0, 12.0] Hole depth (mm)
let b = sphere(ball / 2.0);
let h = cylinder([0, 0, ball / 2.0 - depth], "Z", hole / 2.0, depth + 2.0);
b - h.rotate_y(angle / 2.0) - h.rotate_y(-angle / 2.0)
