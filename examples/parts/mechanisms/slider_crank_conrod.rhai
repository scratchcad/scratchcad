// Slider-crank connecting rod: 80 mm centers, 10 mm big end and 6 mm small end bores, I-section shank
let centers = 80.0; // [40.0, 150.0] Centers (mm)
let big = 10.0; // [6.0, 20.0] Big end bore (mm)
let small = 6.0; // [4.0, 12.0] Small end bore (mm)
let thickness = 8.0; // [5.0, 14.0] Thickness (mm)
let body = polygon([[0, -big / 2.0 - 4.0], [centers, -small / 2.0 - 3.0], [centers, small / 2.0 + 3.0], [0, big / 2.0 + 4.0]]).to_face().extrude([0, 0, thickness]);
let ends = cylinder(big / 2.0 + 5.0, thickness) + cylinder([centers, 0, 0], "Z", small / 2.0 + 4.0, thickness);
let pockets = polygon([[big / 2.0 + 8.0, -big / 2.0], [centers - small / 2.0 - 7.0, -small / 2.0], [centers - small / 2.0 - 7.0, small / 2.0], [big / 2.0 + 8.0, big / 2.0]]).to_face().extrude([0, 0, 2.0]);
body + ends - pockets.translate([0, 0, thickness - 2.0]) - pockets.translate([0, 0, -0.01]) - cylinder([0, 0, -1], "Z", big / 2.0, thickness + 2.0) - cylinder([centers, 0, -1], "Z", small / 2.0, thickness + 2.0)
