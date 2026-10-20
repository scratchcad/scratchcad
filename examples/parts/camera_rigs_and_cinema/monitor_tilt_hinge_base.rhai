// Base half of an on-camera monitor tilt hinge: 40 x 30 x 4 mm leaf, two 12 mm knuckles each a third of the width with a 10.4 mm gap between them for the upper half's knuckle, M6 friction-bolt bore (6.2 mm) through both, 1/4-20 clearance hole (6.5 mm) counterbored 11 mm in the leaf and a 2.5 mm anti-twist pin hole
let leaf_len = 40.0; // [28.0, 70.0] Leaf length (mm)
let width = 30.0; // [24.0, 40.0] Hinge width (mm)
let knuckle_d = 12.0; // [10.0, 16.0] Knuckle diameter (mm)
const t = 4.0;
let kr = knuckle_d / 2.0;
let gap = width / 3.0 + 0.4;
let leaf = box_from_corners([-leaf_len, -width / 2.0, 0], [0, width / 2.0, t]);
let leaf = leaf.fillet(3.0, leaf.edges("|Z and <X"));
let k = cylinder([0, -width / 2.0, kr], "Y", kr, width) + box_from_corners([-kr, -width / 2.0, 0], [0, width / 2.0, kr]);
let k = k - box_from_corners([-kr - 1.0, -gap / 2.0, t], [kr + 1.0, gap / 2.0, knuckle_d + 1.0]);
let part = leaf + k;
let hole_x = -leaf_len + 12.0;
part - cylinder([0, -width, kr], "Y", 3.1, 2.0 * width)
    - cylinder([hole_x, 0, -1.0], "Z", 3.25, t + 2.0)
    - cylinder([hole_x, 0, t - 2.0], "Z", 5.5, 3.0)
    - cylinder([hole_x - 8.0, 0, -1.0], "Z", 1.25, 4.0)
