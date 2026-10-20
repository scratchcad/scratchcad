// Standard No. 1 paper clip: 33 mm long, 0.9 mm wire, double loop of four straight legs joined by three half-turn bends
let len = 33.0; // [25.0, 50.0] Clip length (mm)
const r = 0.45;
// a half torus of bend radius `rr` centred at (cx, cy), on the +X side (side 1) or -X side (side -1)
fn bend(cx, cy, rr, r, side) {
    let half = if side > 0.0 { box_from_corners([0, -rr - 1.0, -1.0], [rr + 1.0, rr + 1.0, 1.0]) } else { box_from_corners([-rr - 1.0, -rr - 1.0, -1.0], [0, rr + 1.0, 1.0]) };
    (torus(rr, r) & half).translate([cx, cy, 0])
}
let right = len - 4.5;
let inner = len - 9.0;
let legs = [
    cylinder([8.0, -4.5, 0], "X", r, right - 8.0),
    cylinder([4.5, 4.5, 0], "X", r, right - 4.5),
    cylinder([4.5, -2.5, 0], "X", r, inner - 4.5),
    cylinder([9.0, 2.0, 0], "X", r, inner - 9.0)
];
let bends = [bend(right, 0.0, 4.5, r, 1.0), bend(4.5, 1.0, 3.5, r, -1.0), bend(inner, -0.25, 2.25, r, 1.0)];
fuse_all(legs + bends)
