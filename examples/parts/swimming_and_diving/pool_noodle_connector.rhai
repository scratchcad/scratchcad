// Pool noodle T-connector: three 65 mm sleeves 40 mm long with 2.5 mm walls, two in line and one at 90 degrees, joined at a 72 mm cube hub, with 6 mm drain holes
let noodle = 65.0; // [55.0, 75.0] Noodle diameter (mm)
let sleeve = 40.0; // [25.0, 60.0] Sleeve length (mm)
const wall = 2.5;
let r = noodle / 2.0 + 0.5;
let hub = box_centered(2.0 * r + 2.0 * wall, 2.0 * r + 2.0 * wall, 2.0 * r + 2.0 * wall);
let ox = r + wall;
let s1 = cylinder([ox - 0.01, 0, 0], "X", r + wall, sleeve) - cylinder([ox - 1.0, 0, 0], "X", r, sleeve + 2.0);
let s2 = cylinder([-ox - sleeve + 0.01, 0, 0], "X", r + wall, sleeve) - cylinder([-ox - sleeve - 1.0, 0, 0], "X", r, sleeve + 2.0);
let s3 = cylinder([0, ox - 0.01, 0], "Y", r + wall, sleeve) - cylinder([0, ox - 1.0, 0], "Y", r, sleeve + 2.0);
hub + s1 + s2 + s3 - cylinder([0, 0, -ox - 1.0], "Z", 3.0, 2.0 * ox + 2.0)
