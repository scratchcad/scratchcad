// Steamer trunk corner cap: 3-way corner 40 mm legs, 1.2 mm steel style with a 6 mm rounded corner and 3 nail holes
let leg = 40.0; // [25.0, 60.0] Leg length (mm)
let t = 1.2; // [0.8, 2.0] Sheet thickness (mm)
let outer = box_from_corners([-t, -t, -t], [leg, leg, leg]);
let o = outer.fillet(6.0, outer.edges("<X and <Y") + outer.edges("<X and <Z") + outer.edges("<Y and <Z"));
let inner = box_from_corners([0, 0, 0], [leg + 1.0, leg + 1.0, leg + 1.0]);
let i = inner.fillet(6.0 - t, inner.edges("<X and <Y") + inner.edges("<X and <Z") + inner.edges("<Y and <Z"));
let cap = o - i;
let trim = box_from_corners([leg * 0.55, leg * 0.55, -t - 1.0], [leg + 1.0, leg + 1.0, leg + 1.0]) + box_from_corners([leg * 0.55, -t - 1.0, leg * 0.55], [leg + 1.0, leg + 1.0, leg + 1.0]) + box_from_corners([-t - 1.0, leg * 0.55, leg * 0.55], [leg + 1.0, leg + 1.0, leg + 1.0]);
cap - trim - cylinder([leg * 0.3, leg * 0.3, -t - 1.0], "Z", 1.0, 3.0) - cylinder([leg * 0.3, -t - 1.0, leg * 0.3], "Y", 1.0, 3.0) - cylinder([-t - 1.0, leg * 0.3, leg * 0.3], "X", 1.0, 3.0)
