// Hammock ceiling hook plate: 100 x 60 mm 5 mm plate with 4 x 6.5 mm holes, 12 mm round-bar hook 40 mm drop
let length = 100.0; // [70.0, 140.0] Plate length (mm)
let width = 60.0; // [40.0, 80.0] Plate width (mm)
let t = 5.0; // [4.0, 8.0] Plate thickness (mm)
let bar = 12.0; // [8.0, 16.0] Hook bar diameter (mm)
let plate = box_centered(length, width, t).translate([0, 0, -t / 2.0]);
let p = plate.fillet(8.0, plate.edges("|Z"));
let r = bar / 2.0;
let ring = (cylinder([0, -r, -40.0], "Y", 15.0, bar) - cylinder([0, -r - 1.0, -40.0], "Y", 15.0 - bar, bar + 2.0)) - box_from_corners([0, -r - 1.0, -40.0], [20.0, r + 1.0, -20.0]);
let holes = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * (length / 2.0 - 12.0), sy * (width / 2.0 - 12.0), -t - 1.0], "Z", 3.25, t + 2.0)); } }
p + box_from_corners([-r, -r, -28.0], [r, r, -t + 0.01]) + ring - compound(holes)
