// 250 ml pear-shaped separatory funnel: 80 mm lofted body, 1.6 mm wall, 19 mm neck, 8 mm stem 60 mm long with a PTFE stopcock and handle
let body_d = 80.0; // [50.0, 120.0] Body diameter (mm)
let r = body_d / 2.0;
let st = [[0.0, 4.0], [20.0, r * 0.45], [60.0, r * 0.9], [90.0, r], [115.0, r * 0.75], [130.0, 9.5]];
let outer = [];
let inner = [];
for s in st {
    outer.push(circle([0, 0, s[0]], [0, 0, 1], s[1]));
    inner.push(circle([0, 0, s[0]], [0, 0, 1], s[1] - 1.6));
}
let body = loft(outer, true) - loft(inner, true);
let neck = cylinder([0, 0, 129.0], "Z", 9.5, 18.0) - cylinder([0, 0, 128.0], "Z", 7.9, 20.0);
let stem = cylinder([0, 0, -60.0], "Z", 4.0, 61.0) - cylinder([0, 0, -61.0], "Z", 2.5, 63.0);
let cock = cylinder([-12.0, 0, -15.0], "X", 6.0, 24.0) + box_from_corners([-16.0, -2.0, -25.0], [-12.0, 2.0, -5.0]);
fuse_all([body, neck, stem, cock])
