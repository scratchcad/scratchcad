// Enclosure door hinge: 50 mm two-wing hinge, 30 mm wings 3 mm, 8 mm knuckle with 4 mm pin, 2 holes per wing (two solids)
let length = 50.0; // [30.0, 80.0] Hinge length (mm)
let wing = 30.0; // [20.0, 45.0] Wing width (mm)
let t = 3.0; // [2.0, 5.0] Wing thickness (mm)
const k = 4.0;
let half = length / 2.0;
let wa = box_from_corners([k + 0.5, 0, 0], [wing, length, t]) + box_from_corners([0, 0, 0], [k + 0.5, half - 0.3, t]) + cylinder([0, 0, k], "Y", k, half - 0.3) + cylinder([0, 0, k], "Y", 1.9, length);
let wb = box_from_corners([-wing, 0, 0], [-k - 0.5, length, t]) + box_from_corners([-k - 0.5, half + 0.3, 0], [0, length, t]) + cylinder([0, half + 0.3, k], "Y", k, half - 0.3) - cylinder([0, -1, k], "Y", 2.1, length + 2.0);
let holes = [];
for x in [wing * 0.6, -wing * 0.6] { for y in [length * 0.25, length * 0.75] { holes.push(cylinder([x, y, -1], "Z", 2.2, t + 2.0)); } }
compound([wa - compound(holes), wb - compound(holes)])
