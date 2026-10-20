// Round speaker grille, 100 mm: 2 mm plate with 0.8 mm-wide hexagonal perforation on 4 mm pitch, solid 6 mm rim, four 3 mm mounting holes
let d = 100.0; // [50.0, 200.0] Grille diameter (mm)
let r = d / 2.0;
let g = cylinder(r, 2.0);
let holes = [];
const pitch = 4.0;
let n = (r / pitch).to_int();
for i in -n..=n { for j in -n..=n {
    let x = i.to_float() * pitch + if j % 2 == 0 { 0.0 } else { pitch / 2.0 };
    let y = j.to_float() * pitch * 0.866;
    if x * x + y * y < (r - 8.0) * (r - 8.0) { holes.push(cylinder([x, y, -1], "Z", 1.6, 4.0)); }
} }
for k in 0..4 { holes.push(cylinder([r - 3.5, 0, -1], "Z", 1.5, 4.0).rotate_z(45.0 + k.to_float() * 90.0)); }
g - compound(holes)
