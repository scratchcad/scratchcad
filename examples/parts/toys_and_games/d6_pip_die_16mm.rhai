// 16 mm six-sided die with rounded edges and drilled pips (opposite faces sum to 7)
let s = 16.0; // [10.0, 30.0] Die size (mm)
let pip = 1.4; // [0.8, 3.0] Pip radius (mm)
let die = box_centered(s, s, s).fillet(s * 0.12);
let h = s / 2.0;
let o = s * 0.27;
// pip layouts in face coordinates
let layouts = [[[0, 0]], [[-1, -1], [1, 1]], [[-1, -1], [0, 0], [1, 1]], [[-1, -1], [1, -1], [-1, 1], [1, 1]], [[-1, -1], [1, -1], [0, 0], [-1, 1], [1, 1]], [[-1, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [1, 1]]];
let pips = [];
for p in layouts[0] { pips.push(sphere([p[0] * o, p[1] * o, h], pip)); }
for p in layouts[5] { pips.push(sphere([p[0] * o, p[1] * o, -h], pip)); }
for p in layouts[1] { pips.push(sphere([h, p[0] * o, p[1] * o], pip)); }
for p in layouts[4] { pips.push(sphere([-h, p[0] * o, p[1] * o], pip)); }
for p in layouts[2] { pips.push(sphere([p[0] * o, h, p[1] * o], pip)); }
for p in layouts[3] { pips.push(sphere([p[0] * o, -h, p[1] * o], pip)); }
die - fuse_all(pips)
