// Figure-8 desktop fastener: 45 mm long, 3 mm thick, 19 mm and 16 mm lobes, 4.5 mm countersunk holes
let length = 45.0; // [35.0, 60.0] Length (mm)
let big = 19.0; // [15.0, 25.0] Large lobe (mm)
let small = 16.0; // [12.0, 22.0] Small lobe (mm)
let t = 3.0; // [2.0, 4.0] Thickness (mm)
let c1 = big / 2.0;
let c2 = length - small / 2.0;
let body = cylinder([c1, 0, 0], "Z", big / 2.0, t) + cylinder([c2, 0, 0], "Z", small / 2.0, t) + box_from_corners([c1, -small / 2.0 + 2.0, 0], [c2, small / 2.0 - 2.0, t]);
let holes = cylinder([c1, 0, -1], "Z", 2.25, t + 2.0) + cone(2.25, 4.5, 2.25).translate([c1, 0, t - 2.24]) + cylinder([c2, 0, -1], "Z", 2.25, t + 2.0) + cone(2.25, 4.5, 2.25).translate([c2, 0, -0.01]).rotate([c2, 0, t / 2.0], "X", 180.0);
body - holes
