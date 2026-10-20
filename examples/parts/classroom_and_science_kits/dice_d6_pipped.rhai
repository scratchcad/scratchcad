// Standard 16 mm six-sided die: rounded 1.5 mm edges, 2.6 mm pip dimples 0.8 mm deep, opposite faces sum to 7
let size = 16.0; // [10.0, 25.0] Die size (mm)
let pip = 2.6; // [1.5, 4.0] Pip diameter (mm)
let s = size / 2.0;
let cube_ = box_centered(size, size, size);
let c = cube_.fillet(1.5, cube_.edges());
let o = size * 0.27;
let pips = [];
fn face_pips(n, o) {
    if n == 1 { [[0.0, 0.0]] }
    else if n == 2 { [[-o, -o], [o, o]] }
    else if n == 3 { [[-o, -o], [0.0, 0.0], [o, o]] }
    else if n == 4 { [[-o, -o], [o, o], [-o, o], [o, -o]] }
    else if n == 5 { [[-o, -o], [o, o], [-o, o], [o, -o], [0.0, 0.0]] }
    else { [[-o, -o], [o, o], [-o, o], [o, -o], [-o, 0.0], [o, 0.0]] }
}
for p in face_pips(1, o) { pips.push(sphere([p[0], p[1], s + pip * 0.25], pip / 2.0 + 0.3)); }
for p in face_pips(6, o) { pips.push(sphere([p[0], p[1], -s - pip * 0.25], pip / 2.0 + 0.3)); }
for p in face_pips(2, o) { pips.push(sphere([s + pip * 0.25, p[0], p[1]], pip / 2.0 + 0.3)); }
for p in face_pips(5, o) { pips.push(sphere([-s - pip * 0.25, p[0], p[1]], pip / 2.0 + 0.3)); }
for p in face_pips(3, o) { pips.push(sphere([p[0], s + pip * 0.25, p[1]], pip / 2.0 + 0.3)); }
for p in face_pips(4, o) { pips.push(sphere([p[0], -s - pip * 0.25, p[1]], pip / 2.0 + 0.3)); }
c - compound(pips)
