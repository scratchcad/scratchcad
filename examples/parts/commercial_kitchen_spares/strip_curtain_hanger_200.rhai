// Walk-in cooler PVC strip curtain hanger plate for 200 mm strips: 200 x 45 mm plate 4 mm thick, J hook over an 8 mm hanger rail at the top and four 6 mm pegs that pass through the strip's punched holes
let strip = 200.0; // [100.0, 300.0] Strip width (mm)
let rail = 8.0; // [6.0, 12.0] Hanger rail thickness (mm)
let pegs = 4; // [2, 6] Number of pegs
const t = 4.0;
const h = 45.0;
let plate = fuse_all([
    box_from_corners([-strip / 2.0, 0, 0], [strip / 2.0, t, h]),
    box_from_corners([-strip / 2.0, 0, h - t], [strip / 2.0, t + rail + t, h]),
    box_from_corners([-strip / 2.0, rail + t, h - 12.0], [strip / 2.0, t + rail + t, h]),
]);
let pins = [];
for i in 0..pegs {
    let x = -strip / 2.0 + strip * (i.to_float() + 0.5) / pegs.to_float();
    pins.push(cylinder([x, -8.0, 15.0], "Y", 3.0, 8.01));
}
plate + fuse_all(pins)
