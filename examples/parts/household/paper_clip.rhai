// Gem paper clip: 1 mm steel wire bent into a 33 x 9 mm double loop
let wire_d = 1.0; // [0.6, 2.0] Wire diameter (mm)
let length = 33.0; // [20.0, 60.0] Length (mm)
let width = 9.0; // [5.0, 15.0] Width (mm)
let r1 = width / 2.0; let r2 = width / 2.0 - 1.5; let r3 = width / 2.0 - 3.0;
let pts = [[0, -r3, 0], [length - r1 - 6.0, -r3, 0]];
let path = wire([
    line([0, -r3, 0], [length - 2.0 * r1 - 4.0, -r3, 0]),
    arc([length - 2.0 * r1 - 4.0, -r3, 0], [length - 2.0 * r1 - 4.0 + r2 + 0.0, 0.0 - (r2 - r3) * 0.0, 0], [length - 2.0 * r1 - 4.0, r2 * 2.0 - r3, 0]),
    line([length - 2.0 * r1 - 4.0, r2 * 2.0 - r3, 0], [r1, r2 * 2.0 - r3, 0]),
    arc([r1, r2 * 2.0 - r3, 0], [r1 - (r1 + r2 - r3) / 1.0 + 0.5, (r2 * 2.0 - r3 - r1 * 0.0) / 2.0 - 1.0, 0], [r1, -r1 - 1.0, 0]),
    line([r1, -r1 - 1.0, 0], [length - r1, -r1 - 1.0, 0])
]);
circle([0, -r3, 0], "X", wire_d / 2.0).to_face().sweep(path)
