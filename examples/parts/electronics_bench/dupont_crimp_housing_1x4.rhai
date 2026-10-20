// Dupont 2.54 mm 1x4 crimp housing: 10.16 x 2.54 x 14 mm, 4 cavities 1.0 mm square, latch window per pin
let pins = 4; // [1, 12] Number of positions
let pitch = 2.54; // [2.0, 2.54] Pitch (mm)
let height = 14.0; // [12.0, 16.0] Length (mm)
let w = pins.to_float() * pitch;
let body = box_from_corners([0, 0, 0], [w, pitch, height]);
let cav = [];
for i in 0..pins {
    let x = (i.to_float() + 0.5) * pitch;
    cav.push(box_from_corners([x - 0.5, pitch / 2.0 - 0.5, -1], [x + 0.5, pitch / 2.0 + 0.5, height + 1.0]));
    cav.push(box_from_corners([x - 0.5, pitch - 0.3, 4.0], [x + 0.5, pitch + 1.0, 6.0]));
}
body - compound(cav)
