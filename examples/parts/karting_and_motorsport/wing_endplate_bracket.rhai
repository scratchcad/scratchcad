// Rear wing endplate bracket: 5 mm aluminium angle 40 mm wide, 60 mm base with two M6 holes (6.4 mm) 30 mm apart, 80 mm upright with three M5 holes (5.3 mm) 20 mm apart for the endplate, a 25 mm triangular gusset in the middle and a 10 mm chamfer on the top corner
let upright_h = 80.0; // [50.0, 120.0] Upright height (mm)
let base_len = 60.0; // [40.0, 90.0] Base length (mm)
let width = 40.0; // [30.0, 60.0] Bracket width (mm)
let thickness = 5.0; // [4.0, 8.0] Plate thickness (mm)
const gusset = 25.0;
let base = box_from_corners([0, -width / 2.0, 0], [base_len, width / 2.0, thickness]);
let up = face(polygon([[0, -width / 2.0, 0], [0, width / 2.0, 0], [0, width / 2.0, upright_h - 10.0], [0, width / 2.0 - 10.0, upright_h], [0, -width / 2.0, upright_h]])).extrude([thickness, 0, 0]);
let g = face(polygon([[0, -2.5, 0], [gusset, -2.5, 0], [0, -2.5, gusset]])).extrude([0, 5.0, 0]);
let body = fuse_all([base, up, g]);
let cuts = [];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([base_len - 15.0, s * 15.0, -1.0], "Z", 3.2, thickness + 2.0));
}
let pitch = min(20.0, (upright_h - thickness - 24.0) / 2.0);
for i in 0..3 {
    cuts.push(cylinder([-1.0, -width / 2.0 + 10.0, upright_h - 15.0 - i.to_float() * pitch], "X", 2.65, thickness + 2.0));
}
body - fuse_all(cuts)
