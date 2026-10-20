// Molecular model carbon atom: 23 mm ball with 4 tetrahedral 4.2 mm peg holes 8 mm deep (109.5 degrees)
let ball = 23.0; // [15.0, 30.0] Atom diameter (mm)
let hole = 4.2; // [3.0, 6.0] Peg hole (mm)
let depth = 8.0; // [5.0, 12.0] Hole depth (mm)
let b = sphere(ball / 2.0);
let dirs = [[1.0, 1.0, 1.0], [1.0, -1.0, -1.0], [-1.0, 1.0, -1.0], [-1.0, -1.0, 1.0]];
let holes = [];
for d in dirs {
    let n = (d[0] * d[0] + d[1] * d[1] + d[2] * d[2]).sqrt();
    let u = [d[0] / n, d[1] / n, d[2] / n];
    let start = ball / 2.0 - depth;
    holes.push(cylinder([u[0] * start, u[1] * start, u[2] * start], u, hole / 2.0, depth + 2.0));
}
b - fuse_all(holes)
