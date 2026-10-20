// Deployable solar panel spring hinge: two 20 x 15 x 3 mm leaves, 5 mm knuckle with 2 mm pin, torsion spring pocket 4 mm (two solids)
let length = 20.0; // [15.0, 30.0] Hinge length (mm)
let leaf = 15.0; // [10.0, 25.0] Leaf width (mm)
let t = 3.0; // [2.0, 4.0] Leaf thickness (mm)
const kr = 2.5;
let seg = length / 3.0;
let a = box_from_corners([kr + 0.3, 0, 0], [kr + leaf, length, t]) + box_from_corners([0, 0, 0], [kr + 0.3, seg - 0.2, t]) + box_from_corners([0, 2.0 * seg + 0.2, 0], [kr + 0.3, length, t]) + cylinder([0, 0, kr], "Y", kr, seg - 0.2) + cylinder([0, 2.0 * seg + 0.2, kr], "Y", kr, seg - 0.2) + cylinder([0, 0, kr], "Y", 0.95, length);
let b = box_from_corners([-kr - leaf, 0, 0], [-kr - 0.3, length, t]) + box_from_corners([-kr - 0.3, seg + 0.2, 0], [0, 2.0 * seg - 0.2, t]) + cylinder([0, seg + 0.2, kr], "Y", kr, seg - 0.4) - cylinder([0, -1, kr], "Y", 1.1, length + 2.0) - cylinder([0, seg + 1.0, kr], "Y", 2.0, seg - 2.0);
compound([a - cylinder([kr + leaf * 0.6, length / 2.0, -1], "Z", 1.1, t + 2.0), b - cylinder([-kr - leaf * 0.6, length / 2.0, -1], "Z", 1.1, t + 2.0)])
