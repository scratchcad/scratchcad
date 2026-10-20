// Wall basket for a blood pressure cuff and bulb: 130 x 65 mm open-top basket 90 mm deep with 2.5 mm walls, a 30 mm hose slot in the front lip, a 160 mm back plate and two 5 mm screw holes
let width = 130.0; // [90.0, 180.0] Basket width (mm)
let depth = 65.0; // [45.0, 90.0] Basket depth (mm)
let height = 90.0; // [60.0, 130.0] Basket height (mm)
const t = 2.5;
let b = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, depth, height]).shell(-t, ">Z");
let back = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, t, height + 70.0]);
back = back.fillet(10.0, back.edges("|Y and >Z"));
let s = b + back;
s = s - box_from_corners([-15.0, depth - t - 1.0, height - 35.0], [15.0, depth + 1.0, height + 1.0]);
s - cylinder([-width / 4.0, -1.0, height + 45.0], "Y", 2.5, t + 2.0) - cylinder([width / 4.0, -1.0, height + 45.0], "Y", 2.5, t + 2.0)
