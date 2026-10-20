// Fountain pen rest for 3 pens: pair of 22 mm tall cradles 100 mm apart joined by a 6 mm bar, each with 3 round notches 14 mm across and 7 mm deep, 4 mm rounded top corners
let pens = 3; // [1, 6] Number of pens
let notch = 14.0; // [10.0, 20.0] Notch width (mm)
let spacing = 100.0; // [60.0, 140.0] Cradle spacing (mm)
let height = 22.0; // [15.0, 35.0] Cradle height (mm)
let gap = 6.0; // [4.0, 12.0] Gap between notches (mm)

const cradle_t = 10.0;
const bar_t = 6.0;
let pitch = notch + gap;
let w = pens * pitch + gap;
let cradles = [];
for s in [-1.0, 1.0] {
    let c = box_from_corners([-w / 2.0, s * spacing / 2.0 - cradle_t / 2.0, 0], [w / 2.0, s * spacing / 2.0 + cradle_t / 2.0, height]);
    c = c.fillet(4.0, c.edges("|Y and >Z"));
    cradles.push(c);
}
let bar = box_from_corners([-bar_t / 2.0, -spacing / 2.0, 0], [bar_t / 2.0, spacing / 2.0, bar_t]);
let rest = fuse_all([fuse_all(cradles), bar]);
let cuts = [];
for i in 0..pens {
    let x = -w / 2.0 + gap + notch / 2.0 + i * pitch;
    cuts.push(cylinder([x, -spacing, height + notch / 2.0 - 7.0], "Y", notch / 2.0, 2.0 * spacing));
}
rest - compound(cuts)
