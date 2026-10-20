// Folding deck chair hinge bracket: 60 x 30 mm 3 mm plate with an 8 mm pivot boss 11 mm tall , one leaf
let length = 60.0; // [40.0, 90.0] Bracket length (mm)
let width = 30.0; // [20.0, 40.0] Bracket width (mm)
let t = 3.0; // [2.0, 5.0] Plate thickness (mm)
let plate = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, t]);
let p = plate.fillet(width / 2.0 - 0.5, plate.edges("|Z and <X"));
let boss = cylinder([0, 0, 0], "Z", width / 2.0, 11.0);
let holes = cylinder([length - 12.0, -7.0, -1], "Z", 2.5, t + 2.0) + cylinder([length - 12.0, 7.0, -1], "Z", 2.5, t + 2.0) + cylinder([length - 30.0, 0, -1], "Z", 2.5, t + 2.0);
p + boss - holes - cylinder([0, 0, -1], "Z", 4.0, 13.0)
