// Double-six domino tile: 48 x 24 x 7.5 mm with rounded edges, centre divider groove, 3-5 pip layout and a brass spinner
let a = 3; // [0, 6] Pips on the left
let b = 5; // [0, 6] Pips on the right
let t = box_centered(48.0, 24.0, 7.5).fillet(1.5) - box_centered(0.8, 18.0, 1.0).translate([0, 0, 3.75]);
let layout = [[], [[0, 0]], [[-1, -1], [1, 1]], [[-1, -1], [0, 0], [1, 1]], [[-1, -1], [1, -1], [-1, 1], [1, 1]], [[-1, -1], [1, -1], [0, 0], [-1, 1], [1, 1]], [[-1, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [1, 1]]];
let pips = [];
for p in layout[a] { pips.push(cylinder([-12.0 + p[0] * 6.0, p[1] * 6.0, 3.0], "Z", 1.5, 2.0)); }
for p in layout[b] { pips.push(cylinder([12.0 + p[0] * 6.0, p[1] * 6.0, 3.0], "Z", 1.5, 2.0)); }
if pips.len() > 0 { t -= fuse_all(pips); }
t + cylinder([0, 0, 3.4], "Z", 1.5, 0.6)
