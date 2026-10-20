// Hydroponic sump pump intake screen: open-bottom box 80 x 80 x 60 mm with a 2.5 mm wall and 3 mm top, 6 vertical 3 mm slots 40 mm tall in each side, a 3 x 3 grid of 4 mm holes in the top, and a 16 mm cable notch in one side's bottom edge
let size = 80.0; // [50.0, 140.0] Box size (mm)
let height = 60.0; // [40.0, 100.0] Box height (mm)
let slots = 6; // [3, 12] Number of slots per side
let notch_d = 16.0; // [8.0, 25.0] Cable notch width (mm)
const wall = 2.5;
const top = 3.0;
let outer = box_centered(size, size, height).translate([0, 0, height / 2.0]);
let inner = box_centered(size - 2.0 * wall, size - 2.0 * wall, height - top + 1.0).translate([0, 0, (height - top - 1.0) / 2.0]);
let box = outer - inner;
let sp = (size - 20.0) / slots.to_float();
let sw = min(3.0, sp * 0.5);
let sl = min(40.0, height - top - 14.0);
let cuts = [];
for k in 0..4 {
    for i in 0..slots {
        let x = -size / 2.0 + 10.0 + sp * (i.to_float() + 0.5);
        cuts.push(box_from_corners([x - sw / 2.0, size / 2.0 - wall - 1.0, 8.0], [x + sw / 2.0, size / 2.0 + 1.0, 8.0 + sl]).rotate_z(k.to_float() * 90.0));
    }
}
let gp = size / 4.0;
for i in [-1.0, 0.0, 1.0] {
    for j in [-1.0, 0.0, 1.0] {
        cuts.push(cylinder([i * gp, j * gp, height - top - 1.0], "Z", 2.0, top + 2.0));
    }
}
let nr = notch_d / 2.0;
cuts.push(cylinder([0, -size / 2.0 - 1.0, 0], "Y", nr, wall + 2.0));
box - fuse_all(cuts)
