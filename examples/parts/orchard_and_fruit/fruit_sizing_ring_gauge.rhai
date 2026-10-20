// Fruit sizing ring gauge: 300 x 80 mm card with sizing holes of 55, 60, 65 and 70 mm (common apple grades) and 10 mm grip end radius
let length = 300.0; // [280.0, 350.0] Gauge length (mm)
let t = 3.0; // [2.0, 5.0] Card thickness (mm)
const w = 80.0;
let card = box_from_corners([0, 0, 0], [length, w, t]);
let card = card.fillet(10.0, card.edges("|Z"));
let holes = [];
for h in [[37.5, 55.0], [101.0, 60.0], [169.5, 65.0], [243.0, 70.0]] { holes.push(cylinder([h[0], w / 2.0, -1.0], "Z", h[1] / 2.0, t + 2.0)); }
card - fuse_all(holes)
