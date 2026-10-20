// Oral syringe drying rack: 4 mm base plate 150 x 60 mm with 3 mm rounded corners carrying 2 rows of 6 pegs, 7 mm pegs 45 mm tall for barrels and 4 mm pegs 50 mm tall for plungers at 24 mm pitch, each peg with a 1 mm tip chamfer, and four 8 mm feet 3 mm high
let pegs = 6; // [3, 10] Pegs per row
let pitch = 24.0; // [16.0, 32.0] Peg spacing (mm)
let barrel_peg_d = 7.0; // [5.0, 12.0] Barrel peg diameter (mm)
let barrel_peg_h = 45.0; // [30.0, 80.0] Barrel peg height (mm)
let plunger_peg_h = 50.0; // [30.0, 80.0] Plunger peg height (mm)
const plate_t = 4.0;
const depth = 60.0;
const plunger_peg_d = 4.0;
let len = pegs * pitch;
let plate = box_from_corners([0, 0, 0], [len, depth, plate_t]);
let plate = plate.fillet(3.0, plate.edges("|Z"));
let parts = [plate];
for i in 0..pegs {
    let x = pitch / 2.0 + i * pitch;
    let p1 = cylinder([x, depth * 0.3, plate_t - 0.5], "Z", barrel_peg_d / 2.0, barrel_peg_h + 0.5);
    parts.push(p1.chamfer(1.0, p1.edges(">Z")));
    let p2 = cylinder([x, depth * 0.72, plate_t - 0.5], "Z", plunger_peg_d / 2.0, plunger_peg_h + 0.5);
    parts.push(p2.chamfer(1.0, p2.edges(">Z")));
}
for c in [[8.0, 8.0], [len - 8.0, 8.0], [8.0, depth - 8.0], [len - 8.0, depth - 8.0]] {
    parts.push(cylinder([c[0], c[1], -3.0], "Z", 4.0, 3.5));
}
fuse_all(parts)
